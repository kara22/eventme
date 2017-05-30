class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :attendees
  has_many :events, through: :attendees do
    def going
      where("attendees.rsvp_status = ?", 'attending')
    end
  end

  def self.find_for_facebook_oauth(auth)
    # find_user either in db or create a new
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h
    user = User.where(provider: auth.provider, uid: auth.uid).first
    user ||= User.where(email: auth.info.email).first # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end
    # get all events from facebook
    auth["extra"]["raw_info"]["events"]["data"].each do |event|
    find_event = Event.find_by(fb_event_id: event.id)
      if event.rsvp_status == "attending"
        if find_event == nil
          new_event = Event.create(fb_event_id: event.id,
                  name: event.name,
                  attending_count: event.attending_count,
                  start_time: event.start_time,
                  end_time: event.end_time,
                  cover: event.cover.source,
                  place_name: event.place ?  event.place.name : nil,
                  place_latitude: event.place ? event.place.location.latitude : nil,
                  place_longitude: event.place ? event.place.location.longitude : nil
                  )
          Attendee.create(user: user, event: new_event, rsvp_status: 'attending')
        else
          find_event.update(
            name: event.name,
            attending_count: event.attending_count,
            start_time: event.start_time,
            end_time: event.end_time,
            cover: event.cover.source,
            place_name: event.place ?  event.place.name : nil,
            place_latitude: event.place ? event.place.location.latitude : nil,
            place_longitude: event.place ? event.place.location.longitude : nil
            )
          if !(find_event.attendees.map(&:user).include?(user))
            Attendee.create(user: user, event: find_event, rsvp_status: 'attending')
          end
        end
      else
        if find_event
          find_event.update(
            name: event.name,
            attending_count: event.attending_count,
            start_time: event.start_time,
            end_time: event.end_time,
            cover: event.cover.source,
            place_name: event.place ?  event.place.name : nil,
            place_latitude: event.place ? event.place.location.latitude : nil,
            place_longitude: event.place ? event.place.location.longitude : nil
            )
          find_event.attendees.where(user: user).update(rsvp_status: event.rsvp_status)
        end
      end
    end

    return user
  end
end

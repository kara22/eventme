class User < ApplicationRecord
  attr_accessor :current_event
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  mount_uploaders :pictures, PictureUploader
  mount_uploader :picture1, PictureUploader
  mount_uploader :picture2, PictureUploader
  mount_uploader :picture3, PictureUploader
  mount_uploader :picture4, PictureUploader
  mount_uploader :picture5, PictureUploader
  mount_uploader :picture6, PictureUploader

  has_many :attendees, dependent: :destroy
  has_many :decisions_as_maker, class_name: 'Decision', foreign_key: 'decision_maker_id'
  has_many :decisions_as_receiver, class_name: 'Decision', foreign_key: 'decision_receiver_id'
  has_many :matches_as_user_1, class_name: 'Match', foreign_key: 'user_1_id'
  has_many :matches_as_user_2, class_name: 'Match', foreign_key: 'user_2_id'
  has_many :messages_as_sender, class_name: 'Message', foreign_key: 'sender_id'
  has_many :messages_as_recipient, class_name: 'Message', foreign_key: 'recipient_id'
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
    user_params[:gender] = auth.extra.raw_info.gender
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h
    user = User.where(provider: auth.provider, uid: auth.uid).first
    user ||= User.where(email: auth.info.email).first # User did a regular sign up in the past.
    if user
      user.update(user_params)
      user.remote_picture1_url = auth.info.image
    else
      user = User.new(user_params)
      user.remote_picture1_url = auth.info.image
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end
    # get all events from facebook

   if auth["extra"]["raw_info"]["events"]
      auth["extra"]["raw_info"]["events"]["data"].each do |event|
        find_event = Event.find_by(fb_event_id: event.id)
        if event.type == "public"
          if event.rsvp_status == "attending"
            if find_event == nil
              new_event = Event.create(fb_event_id: event.id,
                  name: event.name,
                  attending_count: event.attending_count,
                  start_time: event.start_time,
                  end_time: event.end_time,
                  cover: event.cover ? event.cover.source : "http://placehold.it/400x150",
                  place_name: event.place ?  event.place.name : nil,
                  place_latitude: if event.place
                    event.place.location ? event.place.location.latitude : nil
                      else
                        nil
                      end,
                place_longitude: if event.place
                      event.place.location ? event.place.location.longitude : nil
                      else
                        nil
                      end
                      )
              Attendee.create(user: user, event: new_event, rsvp_status: 'attending')
            else
              find_event.update(
                name: event.name,
                attending_count: event.attending_count,
                start_time: event.start_time,
                end_time: event.end_time,
                cover: event.cover ? event.cover.source: "http://placehold.it/400x150",
                place_name: event.place ?  event.place.name : nil,
                place_latitude: if event.place
                                event.place.location ? event.place.location.latitude : nil
                                else
                                nil
                                end,
                place_longitude: if event.place
                                event.place.location ? event.place.location.longitude : nil
                                else
                                nil
                                end
                )
              if !(find_event.attendees.map(&:user).include?(user))
                Attendee.create(user: user, event: find_event, rsvp_status: 'attending')
              end
            end
          end
        else

          # if the event exists in our database and the user rsvp_status is not 'attending'
          # we just update the event and the user attendee with the new data
          if find_event
            find_event.update(
              name: event.name,
              attending_count: event.attending_count,
              start_time: event.start_time,
              end_time: event.end_time,


              cover: event.cover ? event.cover.source: "http://placehold.it/400x150",
              place_name: event.place ?  event.place.name : nil,
              place_latitude: if event.place
                                event.place.location ? event.place.location.latitude : nil
                                else
                                nil
                                end,
              place_longitude: if event.place
                                event.place.location ? event.place.location.longitude : nil
                                else
                                nil
                                end
              )
            find_event.attendees.where(user: user).update(rsvp_status: event.rsvp_status)
          end
        end
      end
    end

    return user
  end


  # Méthode utilisée dans la vue search.html.erb qui permet de renvoyer le tableau des events futurs en commun avec "attendee"
  def common_future_events_with(attendee)
    self.events.where('start_time >= ?', Time.now).order(start_time: :asc) & attendee.events.where('start_time >= ?', Time.now).order(start_time: :asc)
  end

  # Méthode utilisée dans la vue search.html.erb qui permet de renvoyer le tableau des events passés en commun avec "attendee"
 def common_past_events_with(attendee)
    self.events.where('end_time < ?', Time.now) & attendee.events.where('end_time < ?', Time.now)
  end



end

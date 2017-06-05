class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def eventme_pictures_set
    # On arrive ici depuis la show basique du user
    # Cette méthode conduit à la vue qui présente au user toutes ses photos de profil EventMe
    @user = current_user
    authorize @user
  end

  def pictures
    # On arrive dans cette vue depuis la vue eventme_pictures_set.html.erb
    # On récupère le field de la photo EventMe que le user shouaite changer (picture1, picture2, ...)
    @picture_to_change = params[:picture_field_id]
    # On récupère le user qui a fait la demande de changement
    @user = current_user
    # On l'autorise à voir sa liste de photos Facebook pour qu'il puisse choisir
    authorize @user
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end


  def update_description
  # on passe d'abord le user courant à la méthode authorise
  @user = User.find(params[:user_id])
  authorize @user
  @description = params[:description]
  @user.description = @description
  @user.save
  # on récupère la description du user qui doit être dans les params
end


def search
  @decision = Decision.new
  @user = current_user
    # on parse les params passés dans l'input caché de l'index events en objet ruby
    @response = JSON.parse(params["search-user-events"])

    # on crée un nouveau tableau "ids" qui récupère les ids en integer
    ids = @response["ids"].map(&:to_i)

    # on cherche les events qui correspondent aux id's du tableau "ids"
    @events = Event.where(id: ids)

    # on recupère les objets users des events donnés (on a toutes les infos du user en faisant attendee.id, attendee.first_name etc)
    @attendees = @events.map do |event|
      users = event.attendees.map(&:user).flatten
      users.map do |user|
        user.current_event = event
        user
      end
    end.flatten.uniq

    # pundit
    authorize @user
  end

  def update_picture
    # On rentre dans update_picture depuis la vue pictures d'un user
    # On commence par récupérer le user (pas vraiment utile car on pourrait utiliser directement current_user )
    @user = User.find(params[:user_id])
    # ON autorise le user à faire l'update
    authorize @user
    # On récupère l'URL de la photo Facebook sélectionnée par le user (envoyée par le formulaire de pictures)
    @picture_source = params[:fb_radio]
    @picture_field_to_update = params[:picture_field_to_update]

    # En fonction du field que le user a souhaité updater, on upload la bonne photo grace à carrierwave + cloudinary
    case @picture_field_to_update
    when "picture1"
      @user.remote_picture1_url = @picture_source
      @user.save
    when "picture2"
      @user.remote_picture2_url = @picture_source
      @user.save
    when "picture3"
      @user.remote_picture3_url = @picture_source
      @user.save
    when "picture4"
      @user.remote_picture4_url = @picture_source
      @user.save
    when "picture5"
      @user.remote_picture5_url = @picture_source
      @user.save
    when "picture6"
      @user.remote_picture6_url = @picture_source
      @user.save
    end
    # Une fois l'update fait, on redirige vers la show du user (indifférement current_user ou user_id récup dans l'URL)
    redirect_to user_eventme_pictures_set_path(@user)
    # récupère la source (URL) de la photo Facebook
    # réupcère l'id du field où elle doit être placée
    # met à jour le user avec ces infos
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit({avatars: []})
  end
end

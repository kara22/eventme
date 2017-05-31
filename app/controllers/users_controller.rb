class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def pictures
  # On récupère le field que le user shouaite changer (picture1, picture2, ...)
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

def update_picture
    # On rentre dans update_picture depuis la vue pictures d'un user
    # On commence par récupérer le user (pas vraiment utile car on pourrait avoir )
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
    redirect_to user_path(@user)
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

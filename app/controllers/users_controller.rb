class UsersController < ApplicationController
    before_action :find_user, only: [:show, :edit, :update]

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def search
    @user = current_user
    # on parse les params passés dans l'input caché de l'index events en objet ruby
    @response = JSON.parse(params["search-user-events"])

    # on crée un nouveau tableau "ids" qui récupère les ids en integer
    ids = @response["ids"].map(&:to_i)

    # on cherche les events qui correspondent aux id's du tableau "ids"
    @events = Event.where(id: ids)

    # on recupère les objets users des events donnés (on a toutes les infos du user en faisant attendee.id, attendee.first_name etc)
    @attendees = @events.map { |event| event.attendees.map(&:user).flatten }.flatten.uniq
    # pundit
    authorize @user
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit({avatars: []})
  end
end

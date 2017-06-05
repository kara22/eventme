class UserPolicy < ApplicationPolicy
  # scope <=> User
  # record <=> user instance
  # user <=> current_user

  #Le @user qu'on passe à authorize depuis la classe devient le "record" ici. Du coup on authorize l'action
  # que si "user" est égal au record qu'on manipule dans le contrôleur.

  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    true
  end

  def receiver?
    true
  end

  def eventme_pictures_set?
    user == record
  end

  def pictures?
    user == record
  end

  def edit?
    user == record
  end

  def search?
    user == record
  end

  def update?
    user == record
  end

  def update_picture?
    user == record
  end

  def update_description?
    user == record
  end

end

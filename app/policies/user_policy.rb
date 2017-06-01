class UserPolicy < ApplicationPolicy
  # scope <=> User
  # record <=> user instance
  # user <=> current_user
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
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

end

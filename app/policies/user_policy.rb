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

  def edit?
    user == record
  end

  def search?
    user == record
  end

end

class UserPolicy < ApplicationPolicy


  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  class Scope < Scope
    def resolve
      scope
    end
  end


  def edit?
    @current_user == @user
  end

end

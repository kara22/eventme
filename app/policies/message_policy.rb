class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def create?
    user == record
  end

  def destroy?
    user == record
  end
end

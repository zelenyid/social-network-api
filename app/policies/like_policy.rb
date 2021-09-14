class LikePolicy < ApplicationPolicy
  def create?
    record.user != user if user
  end

  def destroy?
    record.user == user if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

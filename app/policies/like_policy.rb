class LikePolicy < ApplicationPolicy
  def create?
    return false if user&.banned?

    record.user != user if user
  end

  def destroy?
    return false if user&.banned?

    record.user == user if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

class FriendshipPolicy < ApplicationPolicy
  def create?
    return false if user&.banned?

    user.admin? || user.user_role? if user
  end

  def update?
    return false if user&.banned?

    record.user_receiver == user if user
  end

  def destroy?
    return false if user&.banned?

    record.user_receiver == user || record.user_sender == user if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

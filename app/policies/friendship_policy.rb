class FriendshipPolicy < ApplicationPolicy
  def create?
    user.admin? || user.user_role? if user
  end

  def update?
    record.user_receiver == user if user
  end

  def destroy?
    record.user_receiver == user || record.user_sender == user if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

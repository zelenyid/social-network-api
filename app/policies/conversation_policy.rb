class ConversationPolicy < ApplicationPolicy
  def show?
    return false if user&.banned?

    user.admin? || user.user_role? if user
  end

  def create?
    return false if user&.banned?

    user.admin? || user.user_role? if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

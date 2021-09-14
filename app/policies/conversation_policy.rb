class ConversationPolicy < ApplicationPolicy
  def show?
    user.admin? || user.user_role? if user
  end

  def create?
    user.admin? || user.user_role? if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

class ProfilePolicy < ApplicationPolicy
  def show?
    return false if user&.banned?

    user.admin? || user.user_role? if user
  end

  def ban?
    return false if user&.banned?

    user&.admin?
  end

  def unban?
    return false if user&.banned?

    user&.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

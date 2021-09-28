class SearchPolicy < ApplicationPolicy
  def by_full_name?
    return false if user&.banned?

    user.admin? || user.user_role? if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

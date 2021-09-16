class CommentPolicy < ApplicationPolicy
  def show?
    return false if user&.banned?

    user.admin? || user.user_role? if user
  end

  def create?
    return false if user&.banned?

    user.admin? || user.user_role? if user
  end

  def update?
    return false if user&.banned?

    record.user == user if user
  end

  def destroy?
    return false if user&.banned?

    record.user == user || record.post.user == user || user.admin? if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

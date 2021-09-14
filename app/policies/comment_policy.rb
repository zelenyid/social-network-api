class CommentPolicy < ApplicationPolicy
  def show?
    user.admin? || user.user_role? if user
  end

  def create?
    user.admin? || user.user_role? if user
  end

  def update?
    record.user == user if user
  end

  def destroy?
    record.user == user || record.post.user == user || user.admin? if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

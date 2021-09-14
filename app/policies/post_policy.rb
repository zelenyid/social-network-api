class PostPolicy < ApplicationPolicy
  def index?
    user.admin? || user.user_role? if user
  end

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
    record.user == user || user.admin? if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

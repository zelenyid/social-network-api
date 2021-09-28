class MessagePolicy < ApplicationPolicy
  def show?
    return false if user&.banned?

    record.sender == user || record.recipient == user if user
  end

  def create?
    return false if user&.banned?

    record.sender == user || record.recipient == user if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

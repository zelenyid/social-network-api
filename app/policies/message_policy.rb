class MessagePolicy < ApplicationPolicy
  def show?
    record.sender == user || record.recipient == user if user
  end

  def create?
    record.sender == user || record.recipient == user if user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end

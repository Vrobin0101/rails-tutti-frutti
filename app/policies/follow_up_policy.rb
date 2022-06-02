class FollowUpPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all where user = curent user
    # end
  end

  def show?
    true
  end

  def create?
    true
  end
end

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all

    if user.persisted?
      can :create, Review
    end
  end
end

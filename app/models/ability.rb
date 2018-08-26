class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      can :create, Review
      can :read, Order, user_id: user.id
    end
  end
end

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is_admin?
      can :manage, :all
    else
      can [:create, :update], Order
      cannot :index, Order
      can [:create, :update, :show, :destroy], Cart
      cannot :index, Cart
      can [:create, :update, :show, :destroy], LineItem
      cannot :index, LineItem
    end
  end
end
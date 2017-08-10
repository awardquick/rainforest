class Ability
  include CanCan::Ability

  def initialize(user)
    can :show, :all
    can :buy, :all
  end
end

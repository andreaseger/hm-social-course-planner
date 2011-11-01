class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all
    else
      can :read, Group
      can :manage, Schedule do |schedule|
        schedule.try(:user) == user
      end
      can :read, Schedule do |schedule|
        schedule.try(:user).try(:classmates).includes? user
      end
    end
  end
end

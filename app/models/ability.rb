class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all
    else
      can :read, Group

      can :manage, Profile do |profile|
        profile.try(:user) == user
      end
      can :manage, Schedule do |schedule|
        schedule.try(:user) == user
      end

      can :read, Schedule do |schedule|
        schedule.try(:user).is_classmate_with user
      end
      can :read, Profile do |profile|
        profile.try(:user).is_classmate_with user
      end
    end
  end
end

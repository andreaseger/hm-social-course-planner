class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all
    else
      #can :read, Group
      #can :read, Booking
      #can :read, Teacher
      #can :read, Room
      #can :read, Timeslot
      #can :read, Day

      can :manage, User do |u|
        u == user
      end

      can :manage, Profile do |profile|
        user.profile == profile
      end
      can :manage, Schedule do |schedule|
        user.schedule == schedule
      end

      can [:show,:read], Schedule do |schedule|
        schedule.user.is_classmate_with user
      end
      can [:show,:read], Profile do |profile|
        profile.user.is_classmate_with user
      end
    end
  end
end

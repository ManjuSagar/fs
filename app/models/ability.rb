# Notes
# LiveSearch action currently has been skipped in individual controllers to bypass the CanCan Authorization Check
# due to performance reasons.

class Ability
  include CanCan::Ability

  def user
    @user
  end

  def super_admin?
    @user.class.name == "SuperAdmin"
  end

  def field_staff?
    @user.class.name == "FieldStaff"
  end

  def ha_staff?
    @user.class.name == "OrgStaff" and Org.current.is_a? "HealthAgency"
  end

  def sc_staff?
    @user.class.name == "OrgStaff" and Org.current.is_a? "StaffingCompany"
  end

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new(:username => 'CanCan User') # guest user (not logged in)
    @user = user
  end
end
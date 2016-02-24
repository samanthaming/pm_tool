class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
      # if user.admin?
      #   can :manage, :all
      # else
      #   can :read, :all
      # end

      # Guest Users
      unless user.id
        can [:show, :index], :all
        can [:create], User

      else
        # Logged in Users

        can :manage, Project do |project|
          project.user == user
        end


      end
  end
end

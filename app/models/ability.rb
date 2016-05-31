class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, :all
    can :create, Article if user.persisted?
    can [:edit, :destroy], Article do |article|
      # allow destroying if this is the users own article, or if they
      # moderate the subreddit containing this article, or if they
      # own the subreddit
      article.user == user || user.moderating.include?(article.subreddit) ||
        article.subreddit.user == user
    end
    can [:create, :destroy], Moderator do |moderator|
      unless moderator.subreddit.nil?
        moderator.subreddit.user == user || user.moderating.include?(moderator.subreddit)
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end

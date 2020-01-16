# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    alias_action :create, :read, :update, :destroy, to: :crud

    if user.is_admin?
      can :manage, :all
    end

    can(:crud, Post) do |post|
      post.user == user
    end

    can(:crud, Comment) do |comment|
      comment.user == user
    end

    # can(:crud, User) do |user|
    #   user == user
    # end
  end
end

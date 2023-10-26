class UsersController < ApplicationController

  before_action :set_user , only: [:edit, :update, :show]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id # To keep the user signed in, when they sign up.
        flash[:notice] = "Welcome to the blog #{@user.username}, you have successfully created your account."
        redirect_to posts_path
    else
        render 'new', status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
        flash[:notice] = "User updated successfully"
        redirect_to @user
    else
        render 'edit', status: :unprocessable_entity
    end
  end

  def show
    @posts = @user.posts
  end

  private

  def user_params
      params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
        flash[:alert] = "You can only update or delete your own post."
        redirect_to @user
    end
  end
end

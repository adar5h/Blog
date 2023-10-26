class PostsController < ApplicationController

  before_action :set_post, only: [:show, :update, :edit, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:update, :destroy, :edit]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
        if @post.save
            flash[:notice] = "Your post is created."
            redirect_to @post
        else
            render 'new', status: :unprocessable_entity
            puts 'Error creating post!'
        end
  end

  def edit
  end

  def update
      if @post.update(post_params)
          flash[:notice] = "Post has been updated."
          redirect_to @post
      else
          render "edit"
      end
  end

  def destroy
    @post.destroy
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user
        flash[:alert] = "You can only update or delete your own article."
        redirect_to @article
    end
  end
  
end

class PostsController < ApplicationController

  before_action :set_post, only: [:show, :update, :edit, :destroy]

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
    @post.user = User.first
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
end

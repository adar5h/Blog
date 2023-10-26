class PostsController < ApplicationController

  def index
    render html: "Home", status: :ok
  end
  
end

class HomeController < ApplicationController

  def default
    redirect_to posts_path if logged_in?
  end

  def about
  end
end

class PostsController < ApplicationController
  def index
    @post = Post.order("RAND()").first
  end
end

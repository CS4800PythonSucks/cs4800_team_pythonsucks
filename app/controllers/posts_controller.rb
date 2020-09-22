class PostsController < ApplicationController
  def index
    @post = Post.order("RAND()").first
    @link = "http://redd.it/" + @post.sub_id
  end
end

class AssignmentsController < ApplicationController
  def harvey
    @post1 = Post.order("RAND()").first
    @post2 = Post.order(:votes).first
  end

  def alan
    @post = Post.order("RAND()").first
  end

  def sean
  	@post = Post.order("RAND()").first
  end
end

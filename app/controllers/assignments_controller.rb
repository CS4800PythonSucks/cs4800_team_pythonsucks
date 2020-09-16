class AssignmentsController < ApplicationController
  def harvey
    @post = Post.order("RAND()").first
  end

  def alan
    @post = Post.order("RAND()").first
  end

end

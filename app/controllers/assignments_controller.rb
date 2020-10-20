require "http"
class AssignmentsController < ApplicationController
  def harvey # For assignment 3
    @post1 = Post.order("RAND()").first
    @post2 = Post.order(:votes).first
  end

  def harvey2 # For assignment 4
    @html_dump = HTTP.get("https://www.cpp.edu").to_s
  end

  def alan
    @post = Post.order("RAND()").first
  end

  def alan2 # For assignment 4
    
  end

  def alan3 
    @post4 = Post.all
  end

  def sean
  	
  end

  def sean2
  end

  def ian
  end

  def jose
    @post = Post.order("RAND()").first
  end
end

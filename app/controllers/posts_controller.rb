class PostsController < ApplicationController
  def index
    @post = Post.order("RAND()").where(broken: false).first
    @current_user = User.find_by(id: session[:user_id])
  end

  def gallery
    @current_user = User.find_by(id: session[:user_id])
    perPage = 30
    params.require(:page)
    params.require(:sort)
    if params[:sort] == "new" then # Sort by created
      if params[:source] != nil and params[:source] != "all" then
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("created DESC").where("broken = ? AND subreddit = ?", false, params[:source])
      else
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("created DESC").where(broken: false)
      end
    elsif params[:sort] == "votes" then # Sort by votes
      if params[:source] != nil and params[:source] != "all" then
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("votes DESC").where("broken = ? AND subreddit = ?", false, params[:source])
      else
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("votes DESC").where(broken: false)
      end
    elsif params[:sort] == "rand" then # Random order
      if params[:source] != nil and params[:source] != "all" then
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("RAND()").where("broken = ? AND subreddit = ?", false, params[:source])
      else
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("RAND()").where(broken: false)
      end
    else # Fall back to sort by created
      if params[:source] != nil and params[:source] != "all" then
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("created DESC").where("broken = ? AND subreddit = ?", [false, params[:source]])
      else
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("created DESC").where(broken: false)
      end
    end
    respond_to do |format|
      format.html
      format.js
      end
  end

  def report
    post = Post.find(params[:id])
    post.update(reported: true)
  end

  def clear
    post = Post.find(params[:id])
    post.update(reported: false, broken: false)
    redirect_to action: 'reported'
  end

  def confirm
    post = Post.find(params[:id])
    post.update(reported: false, broken: true)
    redirect_to action: 'reported'
  end

  def reported
    http_basic_authenticate_or_request_with name: "rockstardev", password: "poop"
    @posts = Post.order("created DESC").where(broken: false, reported: true)
  end

end

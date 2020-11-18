class PostsController < ApplicationController
  
  def index
    @post = Post.order("RAND()").where(broken: false).first
  end

  def gallery
    perPage = 10
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

  def userfavorite
    perPage = 10
    params.require(:page)
    params.require(:sort)
    fav_ids = []
    favorites = Favorite.where("user_id = ?", current_user.id)
    for f in favorites
      fav_ids.push(f.post_id)
    end
    @posts = Post.paginate(page: params[:page], per_page: perPage).order("created DESC").where("broken = ?", false).find(fav_ids)
  end

  def togglefavorite
    if not Favorite.exists?({:user_id=>current_user.id, :post_id=>params[:post]}) then
      Favorite.create(:user_id=>current_user.id, :post_id=>params[:post])
    else
      f = Favorite.where("user_id = ? AND post_id = ?", current_user.id, params[:post]).first
      Favorite.delete(f.id)
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

  def favorite
    before_action :authenticate_user!
    @favorite_exists = Favorite.where(post: @post, user: current_user) == [] ? false : true
  end
end

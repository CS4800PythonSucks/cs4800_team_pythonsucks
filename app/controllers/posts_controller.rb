class PostsController < ApplicationController
  def index
    @post = Post.order("RAND()").first
  end

  def gallery
    perPage = 30
    params.require(:page)
    params.require(:sort)
    if params[:sort] == "new" then # Sort by created
      if params[:source] != nil then
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("created DESC").where(subreddit: params[:source])
      else
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("created DESC")
      end
    elsif params[:sort] == "votes" then # Sort by votes
      if params[:source] != nil then
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("votes DESC").where(subreddit: params[:source])
      else
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("votes DESC")
      end
    elsif params[:sort] == "rand" then # Random order
      if params[:source] != nil then
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("RAND()").where(subreddit: params[:source])
      else
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("RAND()")
      end
    else # Fall back to sort by created
      if params[:source] != nil then
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("created DESC").where(subreddit: params[:source])
      else
        @posts = Post.paginate(page: params[:page], per_page: perPage).order("created DESC")
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
  end

  def confirm
    post = Post.find(params[:id])
    post.update(reported: false, broken: true)
  end

  def reported
    @posts = Post.order("created DESC").where(reported: true)
  end
  
  # def upvote
  #   # Get authorization token from reddit
  #   uri = URI("https://www.reddit.com/api/v1/access_token")
  #   req = Net::HTTP::Post.new(uri, initheader={ "user-agent": config['meme']["user_agent"] })
  #   req.basic_auth config["meme"]["client-id"], config["meme"]["client-secret"]
  #   req["grant_type"] = "password"
  #   req["username"] = config["meme"]["username"]
  #   req["password"] = confit["meme"]["password"]
  #   resp = Net::HTTP.start(uri.hostname, uri.port) {|http|
  #     http.request(req)
  #   }
  #   parsed = JSON.parse(resp.body)
  #   token = parsed["token_type"] + " " + parsed["access_token"]
  #   # Get modhash
  #   uri = URI("https://oauth.reddit.com/api/v1/me.json")
  #   req = Net::HTTP::Get.new(uri, initheader={ "Authorization": token, "User-Agent": config["meme"]["user_agent"] })
  #   resp = Net::HTTP.start(uri.hostname, uri.port) {|http|
  #     http.request(req)
  #   }
  #   parsed = JSON.parse(resp.body)
  #   modhash = parsed["data"]["modhash"]
  #   # Cast upvote
  #   uri = URI("https://oauth.reddit.com/api/vote")
  #   req = Net::HTTP::Post.new(uri, initheader={ "Authorization": token, "User-Agent": config["meme"]["user_agent"] })
  #   req["dir"] = 1
  #   req["id"] = "t1_" + params[:sub_id]
  #   req["rank"] = "wth is this" # TODO: Figure this out
  #   req["uh"] = modhash
  #   resp = Net::HTTP.start(uri.hostname, uri.port) {|http|
  #     http.request(req)
  #   }
  #   # TODO: Test this
  #   puts resp.code + " " + resp.message
  # end
end

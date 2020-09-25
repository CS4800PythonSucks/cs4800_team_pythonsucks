class PostsController < ApplicationController
  def index
    @post = Post.order("RAND()").first
    @is_video = false
    @url = @post.url
    if @url.start_with? "https://www.youtube.com/" then
      @is_video = true
      @url = "https://www.youtube.com/embed/" + @post.url[-11..-1]
    elsif @url.start_with? "https://v.redd.it/" then
      @is_video = true
      @url = "https://www.vrddit.com/?v=www.reddit.com%2Fr%2F" + @post.subreddit + "%2Fcomments%2F" + @post.sub_id
    end
    @link = "https://redd.it/" + @post.sub_id
  end
end

class Post < ApplicationRecord
  def is_video
    if url.start_with? "https://www.youtube.com/" then
      return true
    elsif url.start_with? "https://v.redd.it/" then
      return true
    end
    return false
  end

  def link
    if url.start_with? "https://www.youtube.com/" then
      return "https://www.youtube.com/embed/" + url[-11..-1]
    elsif url.start_with? "https://v.redd.it/" then
      return "https://www.vrddit.com/?v=www.reddit.com%2Fr%2F" + subreddit + "%2Fcomments%2F" + sub_id
    else
      return url
    end
  end

  def source
    return "https://redd.it/" + sub_id
  end

  def timestamp
    t = Time.at(created)
    return t.strftime("%x")
  end
end

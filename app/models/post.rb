class Post < ApplicationRecord
  def is_video # Check if the content is a video
    if url.start_with? "https://www.youtube.com/" or url.start_with? "https://youtu.be" then
      return true
    elsif url.start_with? "https://v.redd.it/" then
      return true
    end
    return false
  end

  def link # Return the link to the content of the post. Construct an embedded link for video content if needed.
    if url.start_with? "https://www.youtube.com/" or url.start_with? "https://youtu.be" then
      return "https://www.youtube.com/embed/" + url[-11..-1]
    elsif url.start_with? "https://v.redd.it/" then
      return "https://www.vrddit.com/?v=www.reddit.com%2Fr%2F" + subreddit + "%2Fcomments%2F" + sub_id
    elsif url.start_with? "https://imgur.com/" or url.start_with? "http://imgur.com/" then
      token = url.split('/')
      return "https://i.imgur.com/" + token.last + ".jpg"
    elsif url.start_with? "https://imgflip.com/" then
      token = url.split('/')
      return "https://i.imgflip.com/" + token.last + ".jpg"
    else
      return url
    end
  end

  def source # Return the link to the reddit post
    return "https://redd.it/" + sub_id
  end

  def timestamp # Return the date the post was created (on reddit)
    t = Time.at(created)
    return t.strftime("%x")
  end

  def nb_title # Return title with spaces replaced with underscored to be non-breaking
    return title.gsub(' ', '_')
  end
end

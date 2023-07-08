require_relative 'feed'

class VinylFeed < Feed
  REGEXPS = [
    /vinyl/i, /turntable/i, /vinil/i, /LP/
  ]

  def feed_id
    3
  end

  def display_name
    "Vinyl Records"
  end

  def description
    "Posts related to Vinyl Records and Turntables"
  end

  def avatar_file
    "images/turntable.jpg"
  end

  def post_matches?(post)
    data = JSON.parse(post.data)
    REGEXPS.any? { |r| post.text =~ r } && !data["reply"].nil?
  end
end

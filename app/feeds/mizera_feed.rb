require_relative 'feed'

class MizeraFeed < Feed
  REGEXPS = [
    /mizera/i, /mzr/i
  ]

  def feed_id
    2
  end

  def display_name
    "Mizera"
  end

  def description
    "Todos posts contendo a palavra 'Mizera'"
  end

  def avatar_file
    "images/mizera.jpg"
  end

  def post_matches?(post)
    REGEXPS.any? { |r| post.text =~ r }
  end
end

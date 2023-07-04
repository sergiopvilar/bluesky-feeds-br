require_relative 'feed'
require 'pry'
require 'json'

class PortugueseFeed < Feed
  REGEXPS = [
    /star ?wars/i, /mandalorian/i, /\bandor\b/i, /boba fett/i, /obi[ \-]?wan/i, /\bahsoka\b/, /\bjedi\b/i,
    /\bsith\b/i, /\byoda\b/i, /Empire Strikes Back/, /chewbacca/i, /Han Solo/, /darth vader/i, /skywalker/i,
    /lightsab(er|re)/i, /clone wars/i
  ]

  def feed_id
    1
  end

  def display_name
    "Português"
  end

  def description
    "Feed com posts em Português"
  end

  def avatar_file
    "images/brasil.png"
  end

  def post_matches?(post)
    langs = JSON.parse(post.data)["langs"]
    return false if langs.nil?

    langs.include?("pt")
  end
end

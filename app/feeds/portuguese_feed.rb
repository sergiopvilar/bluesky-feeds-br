require_relative 'feed'
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
    data = JSON.parse(post.data)
    langs = data["langs"]
    return true if post.repo == "did:plc:yt5efykszuf2r7r37m2sxcbt"
    return false if langs.nil?
    return false if !data["reply"].nil?

    langs.include?("pt")
  end
end

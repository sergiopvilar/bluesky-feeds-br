require 'bundler/setup'

require 'blue_factory/rake'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

require_relative 'app/config'

def get_feed
  if ENV['KEY'].to_s == ''
    puts "Please specify feed key as KEY=feedname (the part of the feed's at:// URI after the last slash)"
    exit 1
  end

  feed_key = ENV['KEY']
  feed = BlueFactory.get_feed(feed_key)

  if feed.nil?
    puts "No feed configured for key '#{feed_key}' - use `BlueFactory.add_feed '#{feed_key}', MyFeed.new`"
    exit 1
  end

  feed
end

desc "Print posts in the feed, starting from the newest ones (limit = N)"
task :print_feed do
  feed = get_feed
  limit = ENV['N'] ? ENV['N'].to_i : 100

  posts = FeedPost.where(feed_id: feed.feed_id).joins(:post).order('feed_posts.time DESC').limit(limit).map(&:post)

  posts.each do |s|
    puts "#{s.time} * https://bsky.app/profile/#{s.repo}/post/#{s.rkey}"
    puts s.text
    puts
  end
end

desc "Destroy all data"
task :destroy_posts do
  Post.destroy_all
  FeedPost.destroy_all

  post_total = Post.count
  postfeed_total = FeedPost.count

  print "Posts total: #{post_total}"
  print "\n"
  print "Feed Post total: #{postfeed_total}"
end

desc "Posts total"
task :post_total do
  post_total = Post.count
  postfeed_total = FeedPost.count

  print "Posts total: #{post_total}"
  print "\n"
  print "Feed Post total: #{postfeed_total}"
end


desc "Rescan all posts and rebuild the feed from scratch"
task :rebuild_feed do
  feed = get_feed

  puts "Cleaning up feed..."
  FeedPost.where(feed_id: feed.feed_id).delete_all

  total = Post.count

  puts "Loading posts..."
  posts = Post.all.to_a

  posts.each_with_index do |post, i|
    print "Processing posts... [#{i + 1}/#{total}]\r"
    $stdout.flush

    if feed.post_matches?(post)
      FeedPost.create!(feed_id: feed.feed_id, post: post, time: post.time)
    end
  end

  puts "Processing posts... Done." + " " * 30
end

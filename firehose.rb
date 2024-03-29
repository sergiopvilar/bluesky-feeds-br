#!/usr/bin/env ruby

require 'bundler/setup'
require_relative 'app/firehose_stream'

$stdout.sync = true

ActiveRecord::Base.logger = nil

def print_help
  puts "Usage: #{$0} [options...]"
  puts "Options:"
  puts
  puts "  * Showing progress: [default: show in development]"
  puts "  -p = show progress dots for each received message"
  puts "  -np = don't show progress dots"
  puts
  puts "  * Logging status changes: [default: log in any mode]"
  puts "  -ns = don't log status changes"
  puts
  puts "  * Logging post text: [default: -lm in development, -nl in production]"
  puts "  -lm = log text of matching posts"
  puts "  -la = log text of every post"
  puts "  -nl = don't log posts"
  puts
  puts "  * Saving posts to db: [default: -da in development, -dm in production]"
  puts "  -da = save all posts to database"
  puts "  -dm = save only matching posts to database"
  puts "  -nd = don't save any posts"
end

firehose = FirehoseStream.new

ARGV.each do |arg|
  case arg
  when '-p'
    firehose.show_progress = true
  when '-np'
    firehose.show_progress = false
  when '-ns'
    firehose.log_status = false
  when '-lm'
    firehose.log_posts = :matching
  when '-la'
    firehose.log_posts = :all
  when '-nl'
    firehose.log_posts = false
  when '-dm'
    firehose.save_posts = :matching
  when '-da'
    firehose.save_posts = :all
  when '-nd'
    firehose.save_posts = false
  when '-h', '--help'
    print_help
    exit 0
  else
    puts "Unrecognized option: #{arg}"
    print_help
    exit 1
  end
end

firehose.start
sleep

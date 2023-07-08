Dir[File.join(__dir__, 'feeds', '*.rb')].each { |f| require(f) }

require 'blue_factory'
require 'sinatra/activerecord'

ActiveRecord::Base.connection.execute "PRAGMA journal_mode = WAL"

BlueFactory.set :publisher_did, 'did:plc:yt5efykszuf2r7r37m2sxcbt'
BlueFactory.set :hostname, 'albatross.bluesky-feeds-br-2.c66.me'

BlueFactory.add_feed 'mizera', MizeraFeed.new
BlueFactory.add_feed 'portuguese', PortugueseFeed.new
BlueFactory.add_feed 'vinyl', VinylFeed.new

# do any additional config & customization on BlueFactory::Server here:
#
# BlueFactory::Server.disable :logging
# BlueFactory::Server.set :port, 4000
#
# BlueFactory::Server.get '/' do
#   redirect 'https://web.example.com'
# end
#
# BlueFactory::Server.before do
#   headers "X-Powered-By" => "BlueFactory/#{BlueFactory::VERSION}"
# end

require 'pub_sub'

#rake feed_generator:connect_to_hub
namespace :feed_generator do
	
	desc "Initiate PubSub connection"
	task connect_to_hub: :environment do
		pubsub = PubSub.new(RSS_URL, HOST + CALLBACK_PATH)
		pubsub.subscribe
		logger.error "Request failed: #{pubsub.error}" if pubsub.error
	end

end

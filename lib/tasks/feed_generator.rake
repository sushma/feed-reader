require 'pub_sub'

#rake feed_generator:get_feed
namespace :feed_generator do
	
  desc "Load feed from "
  task get_feed: :environment do
		url = "http://feeds.feedburner.com/NdtvNews-TopStories?format=xml"
		feed = Feedjira::Feed.fetch_and_parse url
		entries = feed.entries.collect{|e| RssFeed.new title: e.title, published_at: e.published, summary: e.summary.gsub!(/<[^>]*>/,''), url: e.url}
		RssFeed.import entries
  end
	
	desc "Initiate PubSub connection"
	task connect_to_hub: :environment do
		pubsub = PubSub.new(RSS_URL)
		pubsub.subscribe
		logger.info "Request failed: #{pubsub.error}" if pubsub.error
	end

end

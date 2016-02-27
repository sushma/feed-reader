#rake feed_parser:get_feed
namespace :feed_parser do
  desc "Load feed from "
  task get_feed: :environment do
		url = "http://feeds.feedburner.com/NdtvNews-TopStories?format=xml"
		feed = Feedjira::Feed.fetch_and_parse url
		entries = feed.entries.collect{|e| RssFeed.new title: e.title, published_at: e.published, summary: e.summary.gsub!(/<[^>]*>/,''), url: e.url}
		RssFeed.import entries
  end

end

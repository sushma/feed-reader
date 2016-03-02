class RssFeed < ActiveRecord::Base
		
	has_many :comments, -> { where parent_id: nil } 
		
	class << self
		def populate_from_xml(content)
			xml_feeds = Nokogiri.XML(content)
			rss_feed_ids = []
			xml_feeds.xpath("//item").each do |item|
				rss_feed_ids << RssFeed.create(title: item.search('title').text, summary: item.search('description').text.gsub(/<[^>]*>/,''), published_at: item.search('pubDate').text.to_datetime, url: item.search('link').text).id
			end
			notify_rss_feed_created(rss_feed_ids.join(','))
		end
	
		def notify_rss_feed_creation
			listen
			#Wait for notification or timeout and return nil
			RssFeed.connection.raw_connection.wait_for_notify(NOTIFY_TIMEOUT) do |event, pid, rss_feed_ids|
				yield rss_feed_ids
			end
		ensure
			unlisten
		end
		
		########
		private
		########
	
		def listen
			RssFeed.connection.execute "LISTEN rss_feeds_channel"
		end
	
		def unlisten
		  RssFeed.connection.execute "UNLISTEN rss_feeds_channel"
		end
	
		def notify_rss_feed_created(rss_feed_ids)
			RssFeed.connection.execute "NOTIFY rss_feeds_channel, '#{rss_feed_ids}'"
		end
	end
		
end



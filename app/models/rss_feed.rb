class RssFeed < ActiveRecord::Base
		
	has_many :comments, -> { where parent_id: nil }
	
	after_commit :notify_rss_feed_created, on: :create
	
	def self.populate_from_xml(content)
		xml_feeds = Nokogiri.XML(content)
		xml_feeds.xpath("//item").each do |item|
	    RssFeed.create!(title: item.search('title').text, summary: item.search('description').text.gsub(/<[^>]*>/,''), published_at: item.search('pubDate').text.to_datetime, url: item.search('link').text)
		end
	end
	
	def self.notify_rss_feed_creation
	  RssFeed.connection.execute "LISTEN rss_feeds_channel"
	  loop do
	    RssFeed.connection.raw_connection.wait_for_notify do |event, pid, rss_feed|
	      yield rss_feed
	    end
	  end
	ensure
	  RssFeed.connection.execute "UNLISTEN rss_feeds_channel"
	end
	
	########
	private
  ########
	
  def notify_rss_feed_created
    RssFeed.connection.execute "NOTIFY rss_feeds_channel, '#{self.id}'"
	end
	
end



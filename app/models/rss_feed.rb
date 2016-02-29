class RssFeed < ActiveRecord::Base
	
	include Entangled::Model
	entangle only: :create
	
	has_many :comments, -> { where parent_id: nil }
	
	def self.populate_from_xml(content)
		xml_feeds = Nokogiri.XML(content)
		xml_feeds.xpath("//item").each do |item|
			RssFeed.create(title: item.search('title').text, summary: item.search('description').text.gsub(/<[^>]*>/,''), published_at: item.search('pubDate').text.to_datetime, url: item.search('link').text)
		end
	end
	
end

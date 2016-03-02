require 'rails_helper'

describe RssFeed, type: :model do
	
	describe "populate_from_xml" do
		it "should populate the date by parsing xml" do
			expect(RssFeed).to respond_to(:populate_from_xml).with(1).argument
		end
	end
	
	describe "notify_rss_feed_creation" do
		it "should notify when a new feed is created" do
			expect(RssFeed).to respond_to(:notify_rss_feed_creation).with(0).argument
		end
	end
	
end
require 'rails_helper'

describe RssFeed, type: :model do
	describe "Validations" do
		context "On a new rss_feed" do
			it "should not be valid without a title" do
				rss_feed = RssFeed.new summary: 'some summary', published_at: Time.now, url: 'http://google.com'
				expect(rss_feed.valid?).to eq(false)
			end
      
			it "should not be valid without summary" do
				rss_feed = RssFeed.new title: 'title', published_at: Time.now, url: 'http://google.com'
				expect(rss_feed.valid?).to eq(false)
			end
			
			it "should not be valid without published_at time" do
				rss_feed = RssFeed.new title: 'title', summary: 'some summary', url: 'http://google.com'
				expect(rss_feed.valid?).to eq(false)
			end
			it "should not be valid without url" do
				rss_feed = RssFeed.new title: 'title', summary: 'some summary', published_at: Time.now
				expect(rss_feed.valid?).to eq(false)
			end
		end
	end
	
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
require 'rails_helper'

describe PubSub, type: :feature do
	context "Connecting to pubsubhubbub" do
		it "should fetch Fetches the PubSubHubbub Hub URL from a RSS" do
			pubsub = PubSub.new('http://feeds.feedburner.com/NdtvNews-TopStories', HOST + CALLBACK_PATH)
			expect(pubsub.hub_url).to eq('http://pubsubhubbub.appspot.com/')
		end
		
		it "should subscribe to the hub" do
			pubsub = PubSub.new('http://feeds.feedburner.com/NdtvNews-TopStories', HOST + CALLBACK_PATH)
			expect(pubsub).to respond_to(:subscribe).with(0).argument
			expect(pubsub.subscribe.class).to eq(Net::HTTPAccepted)
		end		
	
		it "should unsubscribe to the hub" do
			pubsub = PubSub.new('http://feeds.feedburner.com/NdtvNews-TopStories', HOST + CALLBACK_PATH)
			expect(pubsub).to respond_to(:unsubscribe).with(0).argument
			expect(pubsub.unsubscribe.class).to eq(Net::HTTPAccepted)
		end
	
	end
	
end
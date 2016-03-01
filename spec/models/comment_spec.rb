require 'rails_helper'

describe Comment, type: :model do
	describe "Validations" do
		context "On a new comment" do
			it "should not be valid without a message body" do
				comment = Comment.new body: '', rss_feed_id: 1
				expect(comment.valid?).to eq(false)
			end
      
			it "should not be valid without rss_feed_id association" do
				comment = Comment.new body: 'abc'
				expect(comment.valid?).to eq(false)
			end
		end
	end
end

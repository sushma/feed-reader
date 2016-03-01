class Comment < ActiveRecord::Base
	
	belongs_to :rss_feed, counter_cache: true
	has_many :replies, class_name: "Comment", foreign_key: "parent_id"
	
	validates :body, presence: true
	validates_associated :rss_feed
	
end

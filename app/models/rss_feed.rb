class RssFeed < ActiveRecord::Base
	
	has_many :comments, -> { where parent_id: nil }
	
end

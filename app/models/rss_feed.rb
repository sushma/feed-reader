class RssFeed < ActiveRecord::Base
	
	has_many :comments, -> { where parent_id: nil }
	
	def populate_from_xml
	end
	
end

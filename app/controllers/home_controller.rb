class HomeController < ApplicationController	
	 
	 def index
		 @rss_feeds = RssFeed.order(published_at: :desc).limit(5).offset(get_offset(params[:page] ||= 1))
		 respond_to do |format|
	      format.html
	      format.js 
	   end
	 end

	 ########
	 private
	 ########
 
	 def get_offset(page)
		 case page.to_i
		 when 1 then 0
		 when 2 then 5
		 else
			 page.to_i.pred * 5
		 end
	 end
 
end

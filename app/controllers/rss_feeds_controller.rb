class RssFeedsController < ApplicationController
	include ActionController::Live	 
	 
	def index
		@rss_feeds = RssFeed.order(published_at: :desc).limit(10).offset(get_offset(params[:page] ||= 1))
		respond_to do |format|
			format.html
			format.js 
		end
	end
	 
	def events
		# SSE expects the `text/event-stream` content type
		response.headers['Content-Type'] = 'text/event-stream'
		sse = SSE.new(response.stream, retry: 300, event: "refresh")
		begin
			RssFeed.notify_rss_feed_creation do |feed_id|
				RssFeed.connection.execute "LISTEN rss_feeds_channel"
				sse.write({feed_id: feed_id})
			end
		rescue IOError
			# When the client disconnects, we'll get an IOError on write
		ensure
			sse.close
		end
	end
	
	def show
		@rss_feed = RssFeed.find(params[:id])
		respond_to do |format|
			format.js 
		end
	end
	
	########
	private
	########

	def get_offset(page)
		case page.to_i
		when 1 then 0
		when 2 then 10
		else
			page.to_i.pred * 10
		end
	end
 
end

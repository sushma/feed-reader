class RssFeedsController < ApplicationController
	include ActionController::Live	 
	 
  def events
	  # SSE expects the `text/event-stream` content type
    response.headers['Content-Type'] = 'text/event-stream'
		sse = SSE.new(response.stream, retry: 300, event: "refresh")
    begin
			RssFeed.notify_rss_feed_creation do |feed_id|
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
 
end

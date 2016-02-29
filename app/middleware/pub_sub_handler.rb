require 'pub_sub'
class PubSubHandler

  def initialize(app)
    @app = app
  end

  def call(env)	
    request = Rack::Request.new(env)	
		if env["PATH_INFO"] == URI.parse(CALLBACK_URL).path
			case env['REQUEST_METHOD']
			when 'GET'
				Rails.logger.info RSS_URL
				if request.params['hub.topic'] == RSS_URL
          Rack::Response.new(request.params['hub.challenge'], 200).finish
        else
          Rack::Response.new("not valid", 404).finish
        end
			when 'POST'
        rss_feeds = PubSub.build_rss_feed_hash(request.body.read)			
		    RssFeed.import rss_feeds
				Rails.logger.info content
				Rack::Response.new("Thanks!", 200).finish
			end
		else
			@app.call(env)
		end
	end
	
end
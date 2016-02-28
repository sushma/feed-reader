require 'open-uri'

class PubSub
		
	attr_reader :error
	
	def initialize(feed_url)
		@feed_url = feed_url
		@hub_url = hub_url
		@error = nil
	end
	
	# Fetches the PubSubHubbub Hub URL from a  RSS / Atom feed, if it
  # has one. A hub URL is indicated by <link rel="hub"> in the feed.
  def hub_url
    feed = Nokogiri::XML(open(@feed_url))
		if (hub = feed.xpath("//*[@rel='hub']")).present?
      hub.attribute("href").text
    else
      nil
    end
  end

	def subscribe
		perform_request('subscribe')
	end
	
	def unsubscribe
		perform_request('unsubscribe')
	end
	
	##########
	private
	##########	
	
	#Request type is subscribe or unsubscribe
	def perform_request(request_type)
			(return @error= "Error: Doesn't seem to contain a valid RSS / Atom feed or its feed has no hub specified.") unless @hub_url
      params = {
        'hub.topic'         => @feed_url,
        'hub.mode'          => request_type,
        'hub.callback'      => "https://feed-parser.herokuapp.com/pub_subs/callback",
        'hub.verify'        => 'async'
      }
			send_request(@hub_url, params)
	end
	
	def send_request(url, params)
		uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(params)
    request['Content-Type'] = 'application/x-www-form-urlencoded'
    http.request(request)
  end
 
end
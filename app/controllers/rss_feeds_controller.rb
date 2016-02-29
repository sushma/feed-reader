class RssFeedsController < ApplicationController
	 include Entangled::Controller
	 
	 def index
	    broadcast do
	      @rss_feeds = {}
	    end
	 end
 
end

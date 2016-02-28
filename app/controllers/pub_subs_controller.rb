require 'pub_sub'

class PubSubsController < ApplicationController
  
	skip_before_action :authorize
			
	# Handles responses from Hub servers
	  def callback    
	    case request.method
	    when "GET" then verify_hub # hub is trying to verify a new request
	    when "POST" then update_pub_sub # hub is updating us with a new post
	    else
	      respond_to {|format| format.html{ render text: "Unsupported Request", status: 405 }}
	    end
	  end
		
		private
  
	  def update_pub_sub
			logger.info "NEW RESPONSE FROM HUB"
	    logger.info request.body.read
	    respond_to {|format| format.html { render text: "OK", status: 200 }}
	  end
  
	  def verify_hub
			pubsub = PubSub.new(RSS_URL)
			pubsub.verify_hub
			respond_to do |format|
				if pubsub.error.blank?
				  format.html { render text: params['hub.challenge'] }
				else
	        format.html {render text: "No challenge provided.", status: 404}
				end
			end
	  end
		
end

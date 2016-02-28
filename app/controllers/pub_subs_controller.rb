require 'pub_sub'

class PubSubsController < ActionController::Base
  			
	# Handles responses from Hub servers
	  def callback    
	    case request.method
	    when "GET" # hub is trying to verify a new request
				respond_to {|format| format.html{ render text: params['hub.challenge']  }} 
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
  
end

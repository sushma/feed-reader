class CommentsController < ApplicationController
	before_action :get_rss_feed
		
		
	def index
		@comments = @rss_feed.comments.includes(:replies)
		 respond_to do |format|
	      format.html
        format.js 
     end
	end
	
	def create
		@comment = @rss_feed.comments.new(comment_params)
		@comment.parent_id = params[:comment_id]
		return redirect_to :back, notice: "Your comment wasn't posted!" unless @comment.valid?
		@comment.save
		redirect_to :back, notice: 'Your comment was successfully posted!'
  end
	
	########
	private
  ########
	
  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def get_rss_feed
    return redirect_to :back, notice: "Your comment wasn't posted!" unless params[:rss_feed_id]
		@rss_feed = RssFeed.find_by_id(params[:rss_feed_id]) 
  end
	
end

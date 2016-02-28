class AddCommentsCountToRssFeeds < ActiveRecord::Migration
  def change
		add_column :rss_feeds, :comments_count, :integer, :default => 0
  end
end

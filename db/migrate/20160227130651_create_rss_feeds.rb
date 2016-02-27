class CreateRssFeeds < ActiveRecord::Migration
  def change
    create_table :rss_feeds do |t|
      t.text :title
			t.datetime :published_at
			t.text :summary
			t.string :url
      t.timestamps null: false
    end
  end
end

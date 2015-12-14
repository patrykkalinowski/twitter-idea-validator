class IncreaseIntegerInTwitterSearch < ActiveRecord::Migration
  def change
    change_column :twitter_searches, :last_tweet_id, :integer, limit: 8
  end
end

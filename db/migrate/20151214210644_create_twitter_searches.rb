class CreateTwitterSearches < ActiveRecord::Migration
  def change
    create_table :twitter_searches do |t|
      t.integer :user_id
      t.integer :last_tweet_id

      t.timestamps null: false
    end
  end
end

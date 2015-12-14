class AddSearchQueryToTwitterSearch < ActiveRecord::Migration
  def change
    add_column :twitter_searches, :query, :string
  end
end

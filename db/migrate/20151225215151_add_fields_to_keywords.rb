class AddFieldsToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :follow, :boolean
    add_column :keywords, :favorite, :boolean
    add_column :keywords, :min_sentiment, :decimal
    add_column :keywords, :max_sentiment, :decimal
  end
end

class AddDeletedAtToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :deleted_at, :datetime
    add_index :tweets, :deleted_at
  end
end

class AddActiveToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :active, :boolean, :default => 0
  end
end

class AddSharesToTweets < ActiveRecord::Migration
  def change
    add_reference :tweets, :origin, index: true
  end
end

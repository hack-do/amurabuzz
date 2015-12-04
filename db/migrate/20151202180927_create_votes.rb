class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.float       :value, :default => 0
      t.references  :user
      t.references  :tweet
      t.boolean     :active, :default => true
      t.timestamps
    end

    add_index :votes, :user_id
    add_index :votes, :tweet_id
  end
end

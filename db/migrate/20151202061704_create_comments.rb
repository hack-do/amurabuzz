class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references  :user
      t.references  :tweet
      t.string      :content
      t.boolean     :active, :default => true
      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :tweet_id
  end
end

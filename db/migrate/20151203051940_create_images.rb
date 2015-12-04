class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.attachment  :file
      t.string      :tags
      t.string      :description
      t.string      :folder
      t.string      :image_type
      t.references  :imageable, :polymorphic => true
      t.references  :tweet
      t.boolean     :active, :default => true
      t.timestamps
    end
    add_index :images, :imageable_id
    add_index :images, :tweet_id
  end
end

class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :fname
      t.string :lname
      t.date :dob
      t.text :bio
      t.string :handle
      t.string :email

      t.timestamps
    end
  end
end

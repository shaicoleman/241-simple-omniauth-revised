class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :linkedin_id
      t.string :linkedin_name
      t.string :linkedin_email
      t.string :linkedin_headline
      t.string :linkedin_location
      t.string :linkedin_photo_url
      t.string :linkedin_profile_url
      t.string :linkedin_industry

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :linkedin_id
      t.text   :linkedin_data
      t.timestamps
    end
  end
end

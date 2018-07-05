class CreateVisit < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.integer :user_id, null: false, add_index: true
      t.integer :url_id, null: false, add_index: true
      t.timestamps
      
    end
  end
end

class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :title
      t.string :by
      t.string :music_by
      t.string :stage
      t.integer :user_id
      t.timestamps null: false
    end
    add_index :shows, :user_id
  end
end

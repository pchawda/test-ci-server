class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.integer :show_id
      t.string :name
      t.text :description
      t.string :slug
      t.timestamps null: false
    end
    add_index :characters, :show_id
  end
end

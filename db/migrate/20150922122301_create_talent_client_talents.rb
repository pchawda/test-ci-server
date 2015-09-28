class CreateTalentClientTalents < ActiveRecord::Migration
  def change
    create_table :talent_client_talents do |t|
      t.integer :talent_client_id
      t.integer :talent_id
      t.timestamps null: false
    end
    add_index :talent_client_talents, :talent_id
    add_index :talent_client_talents, :talent_client_id
  end
end

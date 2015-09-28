class CreateTalentClients < ActiveRecord::Migration
  def change
    create_table :talent_clients do |t|
      t.string   :first_name
      t.string   :last_name
      t.string   :quote
      t.string   :quoter
      t.text     :bio
      t.integer  :user_id
      t.index    :user_id
      t.timestamps null: false
    end
  end
end

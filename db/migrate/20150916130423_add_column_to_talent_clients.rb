class AddColumnToTalentClients < ActiveRecord::Migration
  def change
    add_column :talent_clients, :slug, :string
  end
end

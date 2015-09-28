class AddAvatarToTalentClients < ActiveRecord::Migration
  def change
    add_column :talent_clients, :profile_image, :string
  end
end

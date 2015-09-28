class AddColumnGenderToTalentClient < ActiveRecord::Migration
  def change
    add_column :talent_clients, :gender, :integer, limit: 1, default: 0
  end
end

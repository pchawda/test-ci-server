class CreateProductions < ActiveRecord::Migration
  def change
    create_table :productions do |t|
      t.integer :show_id
      t.integer :status, default: 0
      t.datetime :rehearsal_start_date
      t.datetime :preview_date
      t.datetime :opening_date
      t.datetime :closing_date
      t.datetime :extension_option_date
      t.timestamps null: false
    end
    add_index :productions, :show_id
  end
end

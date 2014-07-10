class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.references :table, index: true
      t.integer :assigned_seats
      t.boolean :registered

      t.timestamps
    end
  end
end

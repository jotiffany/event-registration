class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.string :number
      t.integer :max_seats
      t.references :event, index: true

      t.timestamps
    end
  end
end

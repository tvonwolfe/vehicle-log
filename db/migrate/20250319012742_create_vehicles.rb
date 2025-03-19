class CreateVehicles < ActiveRecord::Migration[8.0]
  def change
    create_table :vehicles do |t|
      t.string :vin, null: false
      t.integer :year, null: false
      t.string :manufacturer, null: false
      t.string :model, null: false
      t.string :license_plate_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :vehicles, :vin
    add_index :vehicles, %i[user_id vin], unique: true
  end
end

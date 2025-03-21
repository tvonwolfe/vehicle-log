class CreateLogEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :log_entries do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.integer :mileage, null: false
      t.date :performed_on, null: false

      t.timestamps
    end
  end
end

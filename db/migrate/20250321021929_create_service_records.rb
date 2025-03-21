class CreateServiceRecords < ActiveRecord::Migration[8.0]
  def change
    create_enum :service_types, %i[maintenance repair upgrade other]

    create_table :service_records do |t|
      t.references :log_entry, null: false, foreign_key: true
      t.enum :service_type, enum_type: :service_types, null: false, default: :maintenance
      t.text :description

      t.timestamps
    end
  end
end

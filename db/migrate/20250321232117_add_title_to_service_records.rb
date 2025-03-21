class AddTitleToServiceRecords < ActiveRecord::Migration[8.0]
  def change
    add_column :service_records, :title, :string, null: false
  end
end

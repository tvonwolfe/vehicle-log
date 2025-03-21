class MonetizeServiceRecord < ActiveRecord::Migration[8.0]
  def change
    add_monetize :service_records, :cost
  end
end

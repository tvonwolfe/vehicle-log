class RenameYearToModelYear < ActiveRecord::Migration[8.0]
  def change
    rename_column :vehicles, :year, :model_year
  end
end

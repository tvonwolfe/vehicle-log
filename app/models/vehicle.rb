class Vehicle < ApplicationRecord
  belongs_to :user

  MIN_YEAR = 1925

  validates :year, presence: true, numericality: { greater_than_or_equal_to: MIN_YEAR, less_than_or_equal_to: Date.current.year + 1 }
  validates :manufacturer, :model, :vin, presence: true
  validates :vin, uniqueness: { scope: :user }

  def humanized_name
    "#{year} #{manufacturer} #{model}"
  end
end

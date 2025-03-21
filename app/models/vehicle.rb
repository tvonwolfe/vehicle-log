class Vehicle < ApplicationRecord
  MIN_YEAR = 1925

  belongs_to :user

  has_many :log_entries, dependent: :destroy
  has_many :service_records, through: :log_entries

  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: MIN_YEAR, less_than_or_equal_to: Date.current.year + 1 }
  validates :manufacturer, :model, :vin, presence: true
  validates :vin, uniqueness: { scope: :user }

  def humanized_name = "#{year} #{manufacturer} #{model}"

  def last_mileage_reading = log_entries.last&.mileage
end

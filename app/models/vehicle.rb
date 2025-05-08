class Vehicle < ApplicationRecord
  MIN_MODEL_YEAR = 1925

  belongs_to :user

  has_many :log_entries, dependent: :destroy
  has_many :service_records, through: :log_entries

  normalizes :vin, :license_plate_number, with: ->(v) { v&.strip&.upcase }
  normalizes :manufacturer, :model, with: ->(v) { v&.strip }

  validates :model_year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: MIN_MODEL_YEAR, less_than_or_equal_to: Date.current.year + 1 }
  validates :manufacturer, :model, :vin, presence: true
  validates :vin, uniqueness: { scope: :user }

  def self.valid_model_years = Array(MIN_MODEL_YEAR..(Date.current.year + 1))

  def humanized_name = "#{model_year} #{manufacturer} #{model}"

  def last_mileage_reading = log_entries.select(:mileage).first&.mileage

  def to_param = vin
end

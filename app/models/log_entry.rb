class LogEntry < ApplicationRecord
  belongs_to :vehicle

  validates :performed_on, presence: true
  validates :mileage, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :vehicle_mileage_not_decreased
  validate :performed_on_not_in_future

  private

  def performed_on_not_in_future
    return if performed_on.blank?
    return if performed_on <= Date.current

    errors.add(:performed_on, "can't be in the future")
  end

  def vehicle_mileage_not_decreased
    return if mileage.blank?
    return if vehicle.last_mileage_reading.nil?

    last_recorded_mileage = vehicle.last_mileage_reading.to_i
    return if mileage >= last_recorded_mileage

    errors.add(:mileage, "can't be lower than last mileage reading of #{last_recorded_mileage}")
  end
end

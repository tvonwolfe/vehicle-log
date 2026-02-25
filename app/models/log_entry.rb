class LogEntry < ApplicationRecord
  belongs_to :vehicle

  has_one :service_record, dependent: :destroy

  default_scope { order(performed_on: :desc, created_at: :desc) }

  validates :performed_on, presence: true
  validates :mileage, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :performed_on_not_in_future

  validates_associated :service_record

  accepts_nested_attributes_for :service_record

  private

  def performed_on_not_in_future
    return if performed_on.blank?
    return if performed_on <= Date.current

    errors.add(:performed_on, "can't be in the future")
  end
end

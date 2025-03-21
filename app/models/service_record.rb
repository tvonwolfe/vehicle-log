class ServiceRecord < ApplicationRecord
  MAX_TITLE_LENGTH = 128
  MAX_DESCRIPTION_LENGTH = 10_000

  belongs_to :log_entry, touch: true

  monetize :cost_cents

  enum :service_type, {
    maintenance: "maintenance",
    repair: "repair",
    upgrade: "upgrade",
    other: "other"
  }

  validates :service_type, presence: true, inclusion: { in: service_types.values }
  validates :title, presence: true, length: { maximum: MAX_TITLE_LENGTH }
  validates :description, length: { maximum: MAX_DESCRIPTION_LENGTH }, allow_blank: true

  validate :non_negative_cost

  private

  def non_negative_cost
    return unless cost.negative?

    errors.add(:cost, "can't be less than #{Money.from_cents(0).format}")
  end
end

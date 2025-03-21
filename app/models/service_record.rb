class ServiceRecord < ApplicationRecord
  belongs_to :log_entry, touch: true

  enum :service_type, {
    maintenance: "maintenance",
    repair: "repair",
    upgrade: "upgrade",
    other: "other"
  }

  validates :service_type, presence: true, inclusion: { in: service_types.values }
end

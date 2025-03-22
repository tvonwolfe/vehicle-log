class Invitation < ApplicationRecord
  belongs_to :user, optional: true

  validates :code, presence: true, uniqueness: true

  after_initialize :generate_code, unless: :code?

  private

  def generate_code
    self.code = SecureRandom.alphanumeric
  end
end

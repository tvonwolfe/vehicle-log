# frozen_string_literal: true

class Vehicle < ApplicationRecord
  STARTING_YEAR = 1925

  validates :vin, uniqueness: true
  validates :vin, :make, :model, :year, presence: true
  validates :year, numericality: { only_integer: true }

  validate :model_year_is_valid

  has_many :log_entries, dependent: :destroy

  def friendly_title
    "#{year} #{make} #{model}"
  end

  private

  def model_year_is_valid
    latest_possible_model_year = Date.current.year + 1
    return if year.in? STARTING_YEAR..latest_possible_model_year

    errors.add(
      :year,
      "outside valid range (cannot be less than #{STARTING_YEAR} or greater than #{latest_possible_model_year})"
    )
  end
end

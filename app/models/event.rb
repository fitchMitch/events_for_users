class Event < ApplicationRecord
  has_and_belongs_to_many :users

  # Validations
  validates :title,
            presence: true,
            length: {
              maximum: 50
            }

  validates :description,
            length: {
              maximum: 150
            }

  validates :location,
            presence: true,
            length: {
              maximum: 120
            }

  validates :start_time,
            presence: true

  validates :sec_duration,
            presence: true,
            numericality: true
  validate :sec_duration_positive?, on: :create

  private

  def sec_duration_positive?
    if start_time.present? && start_time < 0
      errors.add(
        :sec_duration,
        'Your meeting cannot have a negative duration'
      )
    end
  end
end

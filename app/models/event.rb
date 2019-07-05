# frozen_string_literal: true

# Event Class
class Event < ApplicationRecord
  has_and_belongs_to_many :users

  ALLOWED_SEARCH_KEYS = %w[
    title_or_description
    location
    start_date
    end_date
  ].freeze

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

  validate :start_is_set_before_end?, on: %i[create update]

  default_scope { order('events.start_time desc') }

  scope :list, -> {
    distinct.left_outer_joins(:events_users)
            .select('events.*, count(events_users.*) AS users_count')
            .group('events.id')
  }

  scope :search_by_location, ->(q_location) {
    where('LOWER(location) like ?', "%#{q_location.downcase}%")
  }

  scope :search_by_title_or_description, ->(q_word) do
    where(
      'LOWER(title) like :q OR LOWER(description) ' \
      'like :q', q: "%#{q_word.downcase}%"
    )
  end

  scope :between_dates, ->(window_start_time, window_end_time) {
    where('start_time >= ?', window_start_time)
    .where('end_time <= ?', window_end_time)
  }

  private

  def start_is_set_before_end?
    test_ok = !start_time.blank? && !end_time.blank? && start_time <= end_time
    unless test_ok
      error_message = 'Your meeting have to finish after its beginning'
      errors.add(:end_time, error_message)
    end
    test_ok
  end
end

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

  validate :begin_set_before_after?, on: [:create, :update]

  default_scope { order('events.start_time asc') }

  scope :list, -> {
      distinct
      .left_outer_joins(:events_users)
      .select("events.*, count(events_users.*) AS user_count")
      .group('events.id')
  }

  scope :search_location, ->(q_location) { where(
    "LOWER(location) like ?",
    "%#{q_location.downcase}%"
    )
  }

  scope :search_by_title_or_description, ->(q_word) do
    where(
      "LOWER(title) like :q OR LOWER(description) " \
      " like :q", q: "%#{q_word.downcase}%"
    )
  end

  scope :between_dates, ->(cust_start_time, cust_end_time) {
    where("start_time >= ?", cust_start_time)
    .where( "end_time <= ?", cust_end_time )
  }

  private

  def begin_set_before_after?
    return if start_time.blank? || end_time.blank?
    errors.add(
      :end_time,
      'Your meeting have to finish after its beginning'
    ) if start_time > end_time
  end
end

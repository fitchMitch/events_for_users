# frozen_string_literal: true

# User Class
class User < ApplicationRecord
  # Relations
  has_and_belongs_to_many :events

  # Validations
  validates :name,
            presence: true,
            length: {
              minimum: 2,
              maximum: 50
            }
end

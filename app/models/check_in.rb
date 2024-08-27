class CheckIn < ApplicationRecord
  validates :patient_id, presence: true

  has_many :assessments
end

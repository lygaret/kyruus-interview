class Assessment < ApplicationRecord
  belongs_to :check_in

  self.inheritance_column = :key
  self.store_full_sti_class = false

  scope :of_key, ->(key) { where(key:) }
  scope :incomplete, ->() { where(response: nil) }
  scope :with_response, ->() { where.not(response: nil) }
  scope :with_result,   ->() { where.not(result: nil) }

  validates :check_in_id, presence: true
  validates :key,         presence: true, inclusion: { in: %w[PHQ] }
end

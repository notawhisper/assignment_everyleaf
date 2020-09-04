class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :deadline, presence: true

  scope :search_for_title, ->(title) { where('title LIKE ?', "%#{title}%") }
  scope :search_for_status, ->(status) { where(status: "#{status}") }
end

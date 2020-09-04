class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :deadline, presence: true

  enum  priority: ["低", "中", "高"]

  scope :search_for_title, ->(title_for_searching) { where('title LIKE ?', "%#{title_for_searching}%") }
  scope :search_for_status, ->(status_for_searching) { where(status: "#{status_for_searching}") }
end

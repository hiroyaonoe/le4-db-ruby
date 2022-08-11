class Board < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments
  validates :title, presence: true

  NUM_LATEST = 10

  def self.latest
    self.order(created_at: :desc).limit(NUM_LATEST)
  end
end

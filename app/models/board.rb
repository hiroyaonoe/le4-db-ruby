class Board < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments
  has_many :board_tags
  has_many :tags, through: :board_tags
  validates :title, presence: true

  NUM_LATEST = 10
  ALL = :all

  def self.latest
    self.latest_order.limit(NUM_LATEST)
  end

  def self.like_title(words)
    self.like(:title, words)
  end

  def self.find_category(category_id)
    if category_id == ALL
      self.all
    else
      self.where(category_id: category_id)
    end
  end
end

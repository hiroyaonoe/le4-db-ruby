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

  def self.where_category(category_id)
    if (category_id == ALL) || Category.where(id: category_id).empty?
      self.all
    else
      self.where(category_id: category_id)
    end
  end

  def self.where_tags(tag_ids)
    query = self
    tag_ids.each do |tag_id|
      query = query.where(id: BoardTag.where(tag_id: tag_id).select(:board_id))
    end
    query
  end
end

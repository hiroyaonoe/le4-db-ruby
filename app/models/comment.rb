class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :board
  validates :content, presence: true

  def self.like_content(words)
    self.like(:content, words)
  end

  def self.where_category(category_id)
    boards = Board.where_category(category_id)
    self.where(board: boards)
  end
end

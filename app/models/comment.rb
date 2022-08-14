class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :board
  validates :content, presence: true

  def self.like_content(words)
    self.like(:content, words)
  end
end

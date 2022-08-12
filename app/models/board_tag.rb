class BoardTag < ApplicationRecord
  belongs_to :board
  belongs_to :tag
  validates :board, uniqueness: { scope: :tag }
end

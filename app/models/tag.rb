class Tag < ApplicationRecord
  has_many :board_tags
  has_many :boards, through: :board_tags
  validates :name, presence: true
end

class Board < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments
  validates :title, presence: true
end

class Category < ApplicationRecord
  has_many :boards
  validates :name, presence: true
end

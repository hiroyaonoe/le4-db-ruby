class Category < ApplicationRecord
  has_many :boards
  validates :name, presence: true

  def self.form_select_params
    self.all.pluck(:name, :id).to_h
  end
end

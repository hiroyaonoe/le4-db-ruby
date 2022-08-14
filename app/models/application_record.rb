class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.latest_order
    self.order(created_at: :desc)
  end

  def self.like(column, words)
    query = self.all
    words.each do |words|
      query = query.where("#{column} LIKE ?", "%#{words}%")
    end
    query
  end
end

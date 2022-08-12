class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.latest_order
    self.order(created_at: :desc)
  end
end

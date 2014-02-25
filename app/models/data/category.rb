class Data::Category < ActiveRecord::Base
  self.table_name = :data_categories

  validates :name, presence: true

  scope :active, -> { where active: true }
end

class District < ActiveRecord::Base
  belongs_to :city
  has_many :addresses
  validates :name, :city_id, presence: true
end

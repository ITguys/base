class City < ActiveRecord::Base
  belongs_to :province
  has_many :districts, dependent: :destroy
  validates :name, :province_id, presence: true
end

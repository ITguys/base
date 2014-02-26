class Province < ActiveRecord::Base
  has_many :cities, dependent: :destroy
  validates :name, presence: true
end

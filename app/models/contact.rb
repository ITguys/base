class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :addresses, dependent: :destroy
  has_one :current_address
  accepts_nested_attributes_for :addresses
end

class Address < ActiveRecord::Base
  belongs_to :contact
  belongs_to :district
end

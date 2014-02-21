class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, confirmation: true
  validates :name, :email, :password, :password_confirmation, presence: true

end

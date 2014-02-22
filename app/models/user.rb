class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, confirmation: true
  validates :name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true

  def locked
    lock_expires_at and lock_expires_at > Time.zone.now
  end

end

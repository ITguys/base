class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessor :notify_user

  has_one :contact, dependent: :destroy

  validates :password, confirmation: true
  validates :password, :password_confirmation, presence: true, if: ->(u) { u.password.present? }
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  accepts_nested_attributes_for :contact

  after_create :send_user_sets_password_notification
  after_update :check_and_send_user_updated_notification

  def locked
    lock_expires_at and lock_expires_at > Time.zone.now
  end

  private

    def send_user_sets_password_notification
      set_reset_password_token
      BaseMailer.check_and_send('user_sets_password', self)
    end

    def check_and_send_user_updated_notification
      if notify_user == '1'
        BaseMailer.check_and_send('user_update_notification', self)
      end
    end

    def set_reset_password_token
      update_attribute(:reset_password_token, SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz'))
    end

end

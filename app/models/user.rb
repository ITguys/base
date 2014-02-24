class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessor :notify_user

  has_one :contact, dependent: :destroy

  validates :password, confirmation: true, presence: true, if: ->(u) { u.password.present? }
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  accepts_nested_attributes_for :contact

  after_create :send_user_sets_password_notification
  after_update :check_and_send_user_updated_notification

  def locked
    lock_expires_at and lock_expires_at > Time.zone.now
  end

  protected

    def send_user_sets_password_notification
      BaseMailer.check_and_send('user_sets_password', self)
    end

    def check_and_send_user_updated_notification
      if notify_user == '1'
        BaseMailer.check_and_send('user_update_notification', self)
      end
    end

end

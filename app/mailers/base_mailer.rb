class BaseMailer < ActionMailer::Base
  default from: "from@example.com"

  def self.check_and_send(name, *args)
    unless Rails.env == 'test'
      self.send(name, *args).deliver
    end
  end

  def user_sets_password(user)
    @user = user
    mail.subject "Set new password"
    mail.to user.email
  end

  def user_resets_password(user)
    @user = user
    mail.subject "Reset password"
    mail.to user.email
  end

  def user_updated_notification(user)
    @user = user
    mail.subject "User updated notification"
    mail.to user.email
  end

  protected

    def check_email
      return if Rails.env == 'test'
    end

end

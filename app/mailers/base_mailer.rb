class BaseMailer < ActionMailer::Base
  default from: "from@example.com"

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
end

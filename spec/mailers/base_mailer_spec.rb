require "spec_helper"

describe BaseMailer do
  before(:each) do
    @user = create(:user)
  end

  it '发送设置密码邮件' do
    @user.update_attribute(:reset_password_token, SecureRandom.hex(15))
    mail = BaseMailer.user_sets_password(@user)
    expect(mail.to).to eq([@user.email])
  end

  it '发送重置密码邮件' do
    @user.update_attribute(:reset_password_token, SecureRandom.hex(15))
    mail = BaseMailer.user_resets_password(@user)
    expect(mail.to).to eq([@user.email])
  end

end

require "spec_helper"

describe BaseMailer do

  it '发送设置密码邮件' do
    user = FactoryGirl.create(:user)
    mail = BaseMailer.user_sets_password(user)
    expect(mail.to).to eq([user.email])
  end

  it '发送重置密码邮件' do
    user = FactoryGirl.create(:user)
    mail = BaseMailer.user_resets_password(user)
    expect(mail.to).to eq([user.email])
  end

end

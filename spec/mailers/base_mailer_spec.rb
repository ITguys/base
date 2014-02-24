require "spec_helper"

describe BaseMailer do
  before(:each) do
    @user = create(:contact).user
  end

  describe ".check_and_send" do
    it "checked failed, return nil" do
      mail = BaseMailer.check_and_send('error_action', 'error_arg')
      expect(mail).to be_nil
    end
    # it "checked success, send the user resets password notification" do
    #   @user.update_attribute(:reset_password_token, SecureRandom.hex(15))
    #   BaseMailer.check_and_send('user_resets_password', @user)
    #   result = BaseMailer.check_and_send('user_resets_password', @user)
    #   expect(result.class).to eq(Mail::Message)
    # end
  end

  describe "#user_sets_password" do
    it 'send user sets password notification(user_sets_password)' do
      @user.update_attribute(:reset_password_token, SecureRandom.hex(15))
      mail = BaseMailer.user_sets_password(@user)
      expect(mail.to).to eq([@user.email])
    end
  end

  describe "#user_resets_password" do
    it 'send user resets password notification(user_resets_password)' do
      @user.update_attribute(:reset_password_token, SecureRandom.hex(15))
      mail = BaseMailer.user_resets_password(@user)
      expect(mail.to).to eq([@user.email])
    end
  end

  describe "#user_updated_notification" do
    it 'send user updated notification(user_updated_notification)' do
      mail = BaseMailer.user_updated_notification(@user)
      expect(mail.to).to eq([@user.email])
    end
  end

end

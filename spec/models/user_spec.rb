require 'spec_helper'

describe User do
  before(:each) do
    @user = create(:user)
  end

  it 'check the user if locked' do
    @user.update_attribute(:failed_logins_count, 3)
    @user.update_attribute(:lock_expires_at, (Time.zone.now + 30))
    expect(@user.reload.locked).to be_true
    @user.update_attribute(:lock_expires_at, (Time.zone.now - 30))
    expect(@user.reload.locked).to be_false
  end

end

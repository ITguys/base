require 'spec_helper'

describe User do
  before(:each) do
    @user = create(:contact).user
  end

  it 'check the user if locked' do
    @user.update_attribute(:failed_logins_count, 3)
    @user.update_attribute(:lock_expires_at, (Time.zone.now + 30))
    expect(@user.reload.locked).to be_true
    @user.update_attribute(:lock_expires_at, (Time.zone.now - 30))
    expect(@user.reload.locked).to be_false
  end

  describe ".search" do
    before(:all) do
      5.times {create(:contact)}
    end

    it "find the records by id" do
      user = User.first
      results = User.search(id: user.id)
      expect(results.count).to eq(1)
      expect(results.to_a).to eq([user])
    end

    it "find the records by email" do
      user = User.first
      results = User.search(email: user.email.upcase)
      expect(results.count).to eq(1)
      expect(results.to_a).to eq([user])
    end

    it "find the records by mobile_phone" do
      user = User.first
      results = User.search(mobile_phone: user.contact.mobile_phone)
      expect(results.count).to eq(User.count)
    end

    it "find the records by name" do
      user = User.first
      results = User.search(name: user.name.upcase)
      expect(results.count).to eq(1)
      expect(results.to_a).to eq([user])
    end

  end

end

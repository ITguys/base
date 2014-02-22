require 'spec_helper'

describe PasswordResetsController do
  before(:each) do
    @user = create(:user)
  end

  describe 'GET #new' do
    it 'render the new template' do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    it 'update the reset password token, redirect to /login' do
      post 'create', email: @user.email
      expect(@user.reload.reset_password_token).to be_present
      expect(response).to redirect_to(login_path)
    end
  end

  describe 'GET #edit' do
    it 'check the user with reset_password_token, render the edit template' do
      @user.update_attribute(:reset_password_token, SecureRandom.hex(15))
      get 'edit', id: @user.reset_password_token
      expect(assigns[:user]).to eq(@user)
      expect(response).to render_template('edit')
    end
  end

  describe 'PATCH #update' do
    it "update the user's password with password and password_confirmation, redirect to root_path" do
      password = 'Aa1111111'
      @user.update_attribute(:reset_password_token, SecureRandom.hex(15))
      patch 'update', user: { password: password, password_confirmation: password }, id: @user.reset_password_token
      expect(assigns[:user].reset_password_token).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end
end

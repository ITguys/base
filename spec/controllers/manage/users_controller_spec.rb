require 'spec_helper'

describe Manage::UsersController do
  before(:each) do
    @user = create(:user)
    session[:user_id] = @user.id
  end

  describe "GET 'index'" do
    it "display user list, render the index template" do
      10.times { create(:user) }
      users = User.order('updated_at DESC')
      get 'index'
      expect(assigns[:users]).to eq(users)
      expect(response).to render_template('index')
    end

    it 'display user list with page number' do
      100.times { create(:user) }
      users = User.order('updated_at DESC').page(2).per(AppConfig.paginate.per_page)
      get 'index', page: 2
      expect(assigns[:users]).to eq(users)
    end
  end

  describe "GET 'new'" do
    it "returns http success, render the new template" do
      get 'new'
      expect(response).to be_success
      expect(response).to render_template('new')
    end

    it "build a new User object" do
      get 'new'
      expect(assigns[:user].new_record?).to be_true
    end
  end

  describe "POST 'create'" do
    before(:all) do
      user = User.new(name: 'Test User', password: 'password', password_confirmation: 'password')
      contact = user.build_contact
      @user_attributes = user.attributes
      @user_attributes['contact_attributes'] = contact.attributes
    end

    it 'when created failed, render the new template, the error messages is present' do
      post 'create', @user_attributes
      expect(assigns[:user].error_messages).to be_present
      expect(response).to render_template('new')
    end

    it 'when created success, redirect to the index page, shown flash[:success] and the new user on it' do
      @user_attributes['email'] = 'test_user@example.com'
      post 'create', @user_attributes
      new_created_user = User.find_by_email(@user_attributes['email'])
      expect(response).to redirect_to(manage_users_path)
      expect(flash[:success]).to be_present
      expect(assigns[:users].first).to eq(new_created_user)
    end
  end

  describe "GET 'edit'" do
    it "returns http success, render the edit template" do
      get 'edit', id: @user.id
      expect(response).to be_success
      expect(response).to render_template('edit')
    end
  end

  describe "PATCH 'update'" do
    before(:each) do
      @user.name = 'Changed Name'
      @attributes = @user.attributes
      @attributes['contact_attributes'] = @user.contact.attributes
    end
    it "when updated failed, render the edit template, the error masswges is present" do
      patch 'update', User.new.attributes, id: @user.id
      expect(response).to render_template('edit')
      expect(assigns[:user].error_messages).to be_present
    end

    it "when updated success, redirect to the index page, shown flash[:success] and the user on it" do
      patch 'update', @attributes, id: @user.id
      expect(response).to redirect_to(manage_users_path)
      expect(flash[:success]).to be_present
      expect(assigns[:users].first).to eq(@user)
    end

    it "when the notify_user be checked, send the notification via email so the user's reset_password_token be present" do
      @attributes['notify_user'] = '1'
      expect(@user.reset_password_token).to be_nil
      patch 'update', @attributes, id: @user.id
      expect(@user.reset_password_token).to be_present
    end
  end

  describe "GET 'destroy'" do
    it "deleted a user, redirect to the index page, shown flash[:success]" do
      user = create(:user)
      delete 'destroy', id: user.id
      expect(User.find_by_email(user.email)).to be_nil
      expect(response).to redirect_to(manage_users_path)
      expect(flash[:success]).to be_present
    end
  end

end

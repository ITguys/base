require 'spec_helper'

describe Manage::UsersController do
  before(:each) do
    @user = create(:contact).user
    session[:user_id] = @user.id
  end

  describe "GET 'index'" do
    it "display user list, render the index template" do
      10.times { create(:user) }
      users = User.order('created_at DESC').page(1).per(AppConfig.paginate.per_page).to_a
      get 'index'
      expect(assigns[:users].to_a).to eq(users)
      expect(response).to render_template('index')
    end

    it 'display user list with page number' do
      20.times { create(:user) }
      users = User.order('created_at DESC').page(2).per(AppConfig.paginate.per_page).to_a
      get 'index', page: 2
      expect(assigns[:users].to_a).to eq(users)
    end

    it "order users list by id, email, name, created_at" do
      20.times { create(:user)}
      %w(id email name created_at).each do |col|
        asc_users = User.order("#{col}").page(1).per(AppConfig.paginate.per_page).to_a
        desc_users = User.order("#{col} DESC").page(1).per(AppConfig.paginate.per_page).to_a
        get 'index', order_by: {col => :asc}
        expect(assigns[:users].to_a).to eq(asc_users)
        get 'index', order_by: {col => :desc}
        expect(assigns[:users].to_a).to eq(desc_users)
      end
    end

    it "search users by id, email, name" do
      user = User.first
      get 'index', query: "#{user.id}, #{user.email}, #{user.name}"
      expect(assigns[:users].to_a).to eq([user])
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
    before(:each) do
      contact = User.new.build_contact
      @user_attributes = {name: 'Test User', password: 'Aa111111', password_confirmation: 'Aa111111'}
      @user_attributes['contact_attributes'] = contact.attributes
    end

    it 'when created failed, render the new template, the error messages is present' do
      post 'create', user: @user_attributes
      expect(assigns[:user].errors.messages).to be_present
      expect(response).to render_template('new')
    end

    it 'when created success, redirect to the index page, shown flash[:success] and the new user on it' do
      @user_attributes[:email] = 'test_user@example.com'
      post 'create', user: @user_attributes
      expect(response).to redirect_to(manage_users_path)
      new_created_user = User.find_by_email(@user_attributes[:email])
      expect(flash[:success]).to be_present
      expect(new_created_user).to be_present
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
    before(:all) do
      @changed_attributes = {name: 'Changed Name', contact_attributes: { mobile_phone: '0123456' }}
    end
    it "when updated failed, render the edit template, the error masswges is present" do
      patch 'update', user: User.new.attributes, id: @user.id
      expect(response).to render_template('edit')
      expect(assigns[:user].errors.messages).to be_present
    end

    it "when updated success, redirect to the index page, shown flash[:success] and the user on it" do
      patch 'update', user: @changed_attributes, id: @user.id
      expect(response).to redirect_to(manage_users_path)
      expect(flash[:success]).to be_present
      expect(@user.reload.name).to eq(@changed_attributes[:name])
    end

    it "when the notify_user be checked, send the notification via email" do
      @changed_attributes[:notify_user] = '1'
      patch 'update', user: @changed_attributes, id: @user.id
      expect(assigns[:user].notify_user).to eq('1')
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

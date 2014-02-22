require 'spec_helper'

describe SessionsController do
  before(:each) do
    @user = create(:user)
  end

  specify { should respond_to(:current_user)}

  describe "GET #new" do
    it "render the new template" do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    it 'shown the different error message, when logged failed' do
      post 'create', email: 'no_email@example.com', password: 'Aa111111' # 输入一个不存在的邮箱
      expect(subject.current_user).to eq(false)
      expect(flash[:error]).to eq('用户不存在，请检查修改您的邮箱，重新登录')
      post 'create', email: @user.email, password: 'incorrect_password' # 错误的密码
      expect(flash[:error]).to eq('用户密码错误，请重新输入密码')
    end

    it 'limitted the user logged again when he logged 3 times in 1 minute with the incorrect password' do
      3.times { post 'create', email: @user.email, password: 'incorrect_password' }
      post 'create', email: @user.email, password: 'incorrect_password' # 第四次以错误的密码登录
      expect(flash[:error]).to eq('您的登录失败次数过多，请在1分钟后重试')
    end

    it 'logged successfully, then redirect to root_path' do
      post 'create', email: @user.email, password: 'Aa111111'
      expect(subject.current_user.name).to eq(@user.name)
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'DELETE #destroy' do
    it 'logged out, then redirect to login_path' do
      session[:user_id] = @user.id
      delete 'destroy'
      expect(session[:user_id]).to eq(nil)
      expect(response).to redirect_to(login_path)
    end
  end

end

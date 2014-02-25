require 'spec_helper'

describe Manage::Data::CategoriesController do

  before(:each) do
    session[:user_id] = create(:user).id
  end

	let(:data_category){ create(:data_category) }

  describe 'GET #index' do

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end

    it 'assigns the requested @data_categories' do
			data_categories = create(:data_category)
      get :index
      expect(assigns(:data_categories)).to match_array([data_categories])
    end
  end

  describe 'GET #new' do
    it "assigns a new data_category to @data_category" do
      get :new
      expect(assigns(:data_category)).to be_a_new(Data::Category)
    end

    it 'render the new template' do
      get :new
      expect(response).to render_template :show
    end
  end

  describe 'GET #show' do
    it 'assigns the requested data_category to @data_category' do
      get :show, id: data_category
      expect(assigns(:data_category)).to eq data_category
    end

    it "renders the :show template" do
      get :show, id: data_category
      expect(response).to render_template :show
    end
  end

  describe 'POST #create' do
    it 'created data category on data' do
      post :create, data_category: {name: '标题', parent_id: 1, description: '描述'}
      expect(data_category.reload.name).to be_present
      expect(response).to render_template('show')
    end
  end

  describe 'GET #edit' do
    it 'edited data category' do
      data_category.attributes = {name: '标题1', parent_id: 1, description: '描述'}
      data_category.save
      get :edit, id: data_category
      expect(assigns[:data_category]).to eq(data_category)
      expect(response).to render_template('show')
    end
  end

end

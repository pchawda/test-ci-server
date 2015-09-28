require 'rails_helper'

RSpec.describe TalentClientsController, type: :controller do
  let(:user){create(:user)}
  let(:user1){create(:user)}

  before(:each) do
    @user_talent_clients = create_list(:talent_client, 3, user: user)
    @user1_talent_clients = create_list(:talent_client, 2, user: user1)
    sign_in user
  end

  it "Get:: index" do
    get :index, {}
    expect( assigns(:talent_clients).map(&:id).sort ).to eq @user_talent_clients.map(&:id).sort
  end

  describe "Get:: show" do
    it "can access own talent client" do
      user_talent_client = @user_talent_clients.first
      get :show, {id: user_talent_client.slug}
      expect( assigns(:talent_client).id ).to eq user_talent_client.id
      expect(response).to render_template(:show)
    end

    it "can not access other user talent_client" do
      sign_out user
      sign_in user1
      user_talent_client = @user_talent_clients.first
      expect {get :show, {id: user_talent_client.slug} }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  it "Get:: new" do
    get :new, {}
    expect(assigns(:talent_client)).to be_a_new(TalentClient)
    expect(response).to render_template(:new)
  end

  describe "Post:: create" do
    it "should create" do
      talent_client_attribute = attributes_for(:talent_client)
      expect{
        post :create, {talent_client: talent_client_attribute}
      }.to change(TalentClient,:count).by(1)
      expect(flash[:notice]).to eq I18n.t('talent_client.create.notice')
      expect(response.redirect_url).to eq talent_clients_url
    end

    it "should create with talent" do
      talents = create_list(:talent, 5)
      talent_client_attribute = attributes_for(:talent_client)
      talent_client_attribute['talent_ids'] = talents.map(&:id)
      expect{
        post :create, {talent_client: talent_client_attribute }
      }.to change(TalentClient,:count).by(1)
      expect(assigns(:talent_client).talents.map(&:id).sort).to eq talents.map(&:id).sort
      expect(flash[:notice]).to eq I18n.t('talent_client.create.notice')
      expect(response.redirect_url).to eq talent_clients_url
    end

    it "should not create, render new" do
      talent_client_attribute = attributes_for(:talent_client, first_name: '')
      expect{
        post :create, {talent_client: talent_client_attribute}
      }.to change(TalentClient,:count).by(0)
      expect(response).to render_template(:new)
    end
  end

  describe "Get:: edit" do
    it "can edit for own talent client" do
      user_talent_client = @user_talent_clients.first
      get :edit, {id: user_talent_client.slug}
      expect( assigns(:talent_client).id ).to eq user_talent_client.id
      expect(response).to render_template(:edit)
    end

    it "can not edit for other talent client" do
      sign_out user
      sign_in user1
      user_talent_client = @user_talent_clients.first
      expect {get :edit, {id: user_talent_client.slug} }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe "PUT:: update" do
    it "should update" do
      talent_client = @user_talent_clients.first
      first_name = 'test'
      last_name = 'good'
      bio = "this is test bio"
      quote = "quote text"
      quoter = "quoter text"
      put :update, {id: talent_client.id, talent_client: {first_name: first_name, last_name: last_name, 
        bio: bio, quoter: quoter, quote: quote
      }}
      expect(assigns(:talent_client).first_name).to eq first_name
      expect(assigns(:talent_client).last_name).to eq last_name
      expect(assigns(:talent_client).bio).to eq bio
      expect(assigns(:talent_client).quote).to eq quote
      expect(assigns(:talent_client).quoter).to eq quoter
      expect(flash[:notice]).to eq I18n.t('talent_client.update.notice')
      expect(response.redirect_url).to eq talent_clients_url
    end

    it "should not update, render edit" do
      talent_client = @user_talent_clients.first
      first_name = ''
      put :update, { id: talent_client.id, talent_client: { first_name: first_name } }
      expect(assigns(:talent_client).reload.first_name).to eq talent_client.first_name
      expect(response).to render_template(:edit)
    end
  end

  describe "Delete:: destroy" do
    it "can delete own talent client" do
      user_talent_client = @user_talent_clients.first
      expect{
        delete :destroy, {id: user_talent_client.slug}
      }.to change(TalentClient,:count).by(-1)
      expect(response.redirect_url).to eq talent_clients_url
    end

    it "can not delete for other talent client" do
      sign_out user
      sign_in user1
      user_talent_client = @user_talent_clients.first
      expect{
        delete :destroy, {id: user_talent_client.slug}
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end


end

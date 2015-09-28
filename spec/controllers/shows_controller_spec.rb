require 'rails_helper'

RSpec.describe ShowsController, type: :controller do
  let(:user){create(:user)}
  let(:user1){create(:user)}

  before(:each) do
    @user_shows = create_list(:show, 3, user: user)
    @user1_shows = create_list(:show, 2, user: user1)
    sign_in user
  end

  it "Get:: index" do
    get :index, {}
    expect( assigns(:shows).map(&:id).sort ).to eq @user_shows.map(&:id).sort
  end

  it "Get:: new" do
    get :new, {}
    expect(assigns(:show)).to be_a_new(Show)
    expect(response).to render_template(:new)
  end

  describe "Get:: show" do
    it "can access own show" do
      user_show = @user_shows.first
      get :show, {id: user_show.slug}
      expect( assigns(:show).id ).to eq user_show.id
      expect(response).to render_template(:show)
    end

    it "can not access other user shows" do
      sign_out user
      sign_in user1
      user_show = @user_shows.first
      expect {get :show, {id: user_show.slug} }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe "Get:: edit" do
    it "can edit for own show" do
      user_show = @user_shows.first
      get :edit, {id: user_show.slug}
      expect( assigns(:show).id ).to eq user_show.id
      expect(response).to render_template(:edit)
    end

    it "can not edit for other show" do
      sign_out user
      sign_in user1
      user_show = @user_shows.first
      expect {get :edit, {id: user_show.slug} }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe "Delete:: destroy" do
    it "can delete own talent client" do
      user_show = @user_shows.first
      expect{
        delete :destroy, {id: user_show.slug}
      }.to change(Show,:count).by(-1)
      expect(response.redirect_url).to eq shows_url
    end

    it "can not delete for other talent client" do
      sign_out user
      sign_in user1
      user_show = @user_shows.first
      expect{
        delete :destroy, {id: user_show.slug}
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe "PUT:: update" do
    it "should update" do
      show = @user_shows.first
      title = 'test'
      by = 'good'
      music_by = "this is test"
      stage = "stage text"
      put :update, {id: show.id, show: {title: title, by: by, 
        music_by: music_by, stage: stage
      }}
      expect(assigns(:show).title).to eq title
      expect(assigns(:show).by).to eq by
      expect(assigns(:show).music_by).to eq music_by
      expect(assigns(:show).stage).to eq stage
      expect(flash[:notice]).to eq I18n.t('shows.update.notice')
      expect(response.redirect_url).to eq shows_url
    end

    it "should not update, render edit" do
      show = @user_shows.first
      title = ''
      put :update, { id: show.id, show: { title: title } }
      expect(assigns(:show).reload.title).to eq show.title
      expect(response).to render_template(:edit)
    end
  end


end

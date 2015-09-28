require 'rails_helper'

RSpec.describe CharactersController, type: :controller do
  let(:user){create(:user)}

  before(:each) do
    @show = create(:show, user: user)
    @show_characters = create_list(:character, 3, show: @show)

    @show1 = create(:show)
    @show1_characters = create_list(:character, 3, show: @show1)

    sign_in user
  end

  it "Get:: index" do
    get :index, {show_id: @show.id}
    expect( assigns(:characters).map(&:id).sort ).to eq @show_characters.map(&:id).sort
  end

  it "Get:: new" do
    get :new, {show_id: @show.id}
    expect(assigns(:character)).to be_a_new(Character)
    expect(response).to render_template(:new)
  end

  describe "Post: create" do
    context "create character" do
      it "create character" do
        character_attr = attributes_for(:character)
        expect{
          post :create, {character: character_attr, show_id: @show.id, commit: "submit"}
        }.to change(Character,:count).by(1)
        expect(flash[:notice]).to eq I18n.t('character.create.notice')
        expect(response.redirect_url).to eq show_characters_url(@show)
      end

      it "create character continuously" do
        character_attr = attributes_for(:character)
        expect{
          post :create, {character: character_attr, show_id: @show.id, commit: "add and continue"}
        }.to change(Character,:count).by(1)
        expect(flash[:notice]).to eq I18n.t('character.create.notice')
        expect(response.redirect_url).to eq new_show_character_url(@show)
      end
    end

    context "Error in the form" do
      it "should not save character" do
        character_attr = attributes_for(:character, name: '')
        expect{
          post :create, {character: character_attr, show_id: @show.id, commit: "submit"}
        }.to change(Character,:count).by(0)
        expect(flash[:error]).to eq "Name can't be blank"
        expect(response).to render_template(:new)
      end
    end
  end

  describe "Get:: edit" do
    it "can edit for own character" do
      character = @show_characters.first
      get :edit, {show_id: @show.id, id: character.slug }
      expect( assigns(:character).id ).to eq character.id
      expect(response).to render_template(:edit)
    end

    it "can not edit for other talent client" do
      character = @show1_characters.first
      expect {get :edit, {id: character.slug, show_id: @show1.id} }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe "PUT:: update" do
    it "should update" do
      character = @show_characters.first
      name = 'test name'
      description = "this is test data"
      put :update, {id: character.slug, show_id: @show.id, character: { name: name, description: description }}
      expect(assigns(:character).name).to eq name
      expect(assigns(:character).description).to eq description
      expect(flash[:notice]).to eq I18n.t('character.update.notice')
      expect(response.redirect_url).to eq show_characters_url(@show)
    end

    it "should not update, render edit" do
      character = @show_characters.first
      name = ''
      description = "this is test data"
      put :update, {id: character.slug, show_id: @show.id, character: { name: name, description: description }}
      expect(assigns(:character).reload.name).to eq character.name
      expect(response).to render_template(:edit)
    end
  end

  describe "Get:: show" do
    it "can access own talent client" do
      character = @show_characters.first
      get :show, {id: character.slug, show_id: @show.id}
      expect( assigns(:character).id ).to eq character.id
      expect(response).to render_template(:show)
    end

    it "can not access other user talent_client" do
      character = @show1_characters.first
      expect {get :show, {id: character.slug, show_id: @show1.id} }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe "Delete:: destroy" do
    it "can delete own talent client" do
      character = @show_characters.first
      expect{
        delete :destroy, {id: character.slug, show_id: @show.id}
      }.to change(Character,:count).by(-1)
      expect(response.redirect_url).to eq show_characters_url(@show)
    end

    it "can not delete for other talent client" do
      character = @show1_characters.first
      expect{
        delete :destroy, {id: character.slug, show_id: @show1.id}
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end

end

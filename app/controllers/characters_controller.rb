class CharactersController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user_show, only: [:index, :new, :create, :edit, :update, :show, :destroy]

  def index
    @characters = @show.characters
  end

  def new
    @character = @show.characters.new
  end

  def create
    @character = @show.characters.new(character_params)

    if @character.save
      if params["commit"].downcase == "add and continue"
        redirect_to new_show_character_path(@show), notice: t('character.create.notice')
      else
        redirect_to show_characters_path(@show), notice: t('character.create.notice')
      end
    else
      flash.now[:error] = @character.errors.full_messages.join('<br/>').html_safe
      render 'new'
    end
  end

  def edit
    @character = @show.characters.find(params[:id])
  end

  def update
    @character = @show.characters.find(params[:id])
    if @character.update_attributes(character_params)
      redirect_to show_characters_path(@show), notice: t('character.update.notice')
    else
      flash.now[:error] = @character.errors.full_messages.join('<br/>').html_safe
      render 'edit'
    end
  end

  def show
    @character = @show.characters.find(params[:id])
  end

  def destroy
    character = @show.characters.find(params[:id])
    character.destroy
    redirect_to show_characters_path(@show), notice: t('character.delete.notice')
  end

  private

  def character_params
    params.require(:character).permit(:name, :description)
  end

  def current_user_show
    @show = current_user.shows.find(params[:show_id])
  end

end

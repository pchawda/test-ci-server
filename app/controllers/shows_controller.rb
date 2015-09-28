class ShowsController < ApplicationController
  before_action :authenticate_user!

  def index
    @shows = current_user.shows.page(params[:page]).per(8)
  end

  def new
    @show = current_user.shows.new
  end

  def show
    @show = current_user.shows.find(params[:id])
  end

  def edit
    @show = current_user.shows.find(params[:id])
  end

  def destroy
    show = current_user.shows.find(params[:id])
    show.destroy
    redirect_to shows_path, notice: t('shows.delete.notice')
  end

  def create
    @show = current_user.shows.new(show_params)
    if @show.save
      redirect_to shows_path, notice: t('shows.create.notice')
    else
      flash.now[:error] = @show.errors.full_messages.join('<br/>').html_safe
      render 'new'
    end
  end

  def update
    @show = current_user.shows.find(params[:id])
    if @show.update_attributes(show_params)
      redirect_to shows_path, notice: t('shows.update.notice')
    else
      flash.now[:error] = @show.errors.full_messages.join('<br/>').html_safe
      render 'edit'
    end
  end

  private

  def show_params
    params.require(:show).permit(:title, :by, :music_by, :stage)
  end


end

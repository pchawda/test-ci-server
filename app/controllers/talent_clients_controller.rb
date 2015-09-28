class TalentClientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @talent_clients = current_user.talent_clients.recent.page(params[:page]).per(8)
  end

  def show
    @talent_client = current_user.talent_clients.find(params[:id])
  end

  def new
    @talent_client = current_user.talent_clients.new
  end

  def create
    @talent_client = current_user.talent_clients.new(talent_client_params)
    if @talent_client.save
      redirect_to talent_clients_path, notice: t('talent_client.create.notice')
    else
      flash.now[:error] = @talent_client.errors.full_messages.join('<br/>').html_safe
      render 'new'
    end
  end

  def edit
    @talent_client = current_user.talent_clients.find(params[:id])
  end

  def update
    @talent_client = current_user.talent_clients.find(params[:id])
    if @talent_client.update(talent_client_params)
      redirect_to talent_clients_path, notice: t('talent_client.update.notice')
    else
      flash.now[:error] = @talent_client.errors.full_messages.join('<br/>').html_safe
      render 'edit'
    end
  end

  def destroy
    talent_client = current_user.talent_clients.find(params[:id])
    talent_client.destroy
    redirect_to talent_clients_path, notice: t('talent_client.delete.notice')
  end

  private

  def talent_client_params
    params.require(:talent_client).permit(:first_name, :last_name, :quote, :quoter, :bio, :profile_image, :gender, talent_ids: [])
  end

end

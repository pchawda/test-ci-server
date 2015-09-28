class ProductionsController < ApplicationController
  before_action :authenticate_user!
  before_action :current_user_show, only: [:index, :new, :create, :edit, :update, :show, :destroy]

  def index
    @production = @show.productions
  end

  private

  def production_params
    params.require(:character).permit(:status, :rehearsal_start_date, :preview_date, :opening_date, :closing_date, :extension_option_date)
  end

  def current_user_show
    @show = current_user.shows.find(params[:show_id])
  end
end

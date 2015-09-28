require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  it "should not access admin panel by user" do
    user = create(:user)
    sign_in user
    get :index, {}
    expect(flash["notice"]).to eq I18n.t('web.alerts.administrators_only')
    expect(response).to be_redirect
    expect(response.redirect_url).to eq root_url
  end

end

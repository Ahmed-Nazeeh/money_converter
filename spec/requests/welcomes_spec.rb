require 'rails_helper'

RSpec.describe "Welcomes", type: :request do
  before do 
    params = { email: "ahmed@example.com", password: "123456", name: "Ahmed" }
    post user_registration_path,  params:{ user: params }
    params = { email: "ahmed@example.com", password: "123456" }
    post user_session_path, params: params
  end
  
  describe "GET /index" do
    it "should show wlecome to user" do 
      get site_index_path
      expect(response).to have_http_status(:ok)
      expect(response).to have_http_status(200)
    end
  end
end

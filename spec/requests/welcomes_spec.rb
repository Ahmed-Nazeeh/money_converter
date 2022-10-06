require 'rails_helper'

RSpec.describe "Welcomes", type: :request do
  describe "GET /index" do
    it "should show wlecome to user" do 
      get site_index_path
      expect(response).to have_http_status(:ok)
      expect(response).to have_http_status(200)
    end
  end
end

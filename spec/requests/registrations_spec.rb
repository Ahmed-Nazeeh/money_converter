require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe "POST /registrations" do
    it "creates a user in the database" do
      params = { email: "ahmed@example.com", password: "secrete1234" }
      post user_registration_path, params: params
      expect(response).to have_http_status(200)
      expect(User.all.count).to eq(1)
    end
  end
end

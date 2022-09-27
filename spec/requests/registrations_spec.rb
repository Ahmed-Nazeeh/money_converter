require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe "POST /registrations" do
    it "creates a user in the database" do
      params = { email: "ahmed@example.com", password: "123456" }
      post user_registration_path,  params:{ user: params }
      expect(response).to have_http_status(302)
      expect(User.all.count).to eq(1)
    end
  end
end

require 'rails_helper'

RSpec.describe "Exchange", type: :request do
  describe "post /exchange" do
    before do 
      params = { email: "ahmed@example.com", password: "123456", name: "Ahmed" }
      post user_registration_path,  params:{ user: params }
      params = { email: "ahmed@example.com", password: "123456" }
      post user_session_path, params: params
    end
    
    it "should pass with existing params" do
      params = { enter_value: 1000, convert_from: "USD", convert_to: "USD" }
      post exchange_path(format: :turbo_stream), params: params
      expect(response).to have_http_status(:ok)
      expect(response).to have_http_status(200)
      expect(response.media_type).to eq Mime[:turbo_stream]
      # expect(response).to render_template(layout: true)
      # expect(response).to include('<turbo-stream action="update" target="result">')
    end
    it "should fail with one or more than one param empty" do 
      params = { enter_value: 1000, convert_from: "USD", convert_to: "" }
      post exchange_path, params: params
      expect(response).to have_http_status(422)
      expect(response).to have_http_status(:unprocessable_entity)
      expect(flash[:alert]).to match(/Something went wrong. Please fill and try again./)
    end

  end
end
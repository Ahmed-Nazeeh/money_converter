require 'rails_helper'

RSpec.describe "Exchange", type: :request do
  describe "post /exchange" do
    it "works! (now write some real specs)" do
      params = { enter_value: 1000, convert_from: "USD", convert_to: "USD" }
      post exchange_path(format: :turbo_stream), params: params
      expect(response).to have_http_status(:ok)
      expect(response).to have_http_status(200)
      expect(response.media_type).to eq Mime[:turbo_stream]
      # expect(response).to render_template(layout: true)
      # expect(response).to include('<turbo-stream action="update" target="result">')
    end
  end
end

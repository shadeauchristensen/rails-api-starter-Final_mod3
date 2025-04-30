require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "GET api/v1/users/:id/schedule" do
    it 'HAPPY PATH - returns a user with their schedule' do
      user = User.create!(id: "1", first_name: "Test", last_name: "User", email: "test@example.com")
      get "/api/v1/users/#{user.id}/schedule"

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:id]).to eq(user.id.to_s)
    end

    it 'SAD PATH - returns a 404 if the user does not exist' do
      get "/api/v1/users/999999/schedule"

      expect(response).to have_http_status(:not_found)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:error]).to eq('User not found')
    end
  end
end

require 'rails_helper'

RSpec.describe 'Api::V1::Shows', type: :request do
  describe 'POST /api/v1/schedules/:schedule_id/shows' do
    let!(:schedule) { Schedule.create!(title: 'Test Festival', date: '2025-07-10') }

    it 'creates a show for a valid schedule' do
      schedule = Schedule.first
      show_params = {
        show: {
          id: '1',
          artist: 'Test Band',
          location: 'Main Stage',
          date: '2025-07-09',
          time: '18:00'
        }
      }

      post "/api/v1/schedules/#{schedule.id}/shows", params: show_params

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:attributes][:artist]).to eq('Test Band')
    end

    it 'returns 404 if schedule does not exist' do
      post "/api/v1/schedules/999999/shows", params: {
        show: { id: '9999999', artist: 'Test', location: 'Somewhere', date: '2025-07-07', time: '12:00' }
      }

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:error]).to eq('Schedule not found')
    end

    it 'returns 422 if required fields are missing' do
      schedule = Schedule.first
      post "/api/v1/schedules/#{schedule.id}/shows", params: {
        show: { artist: '' }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:error]).to include("can't be blank")
    end
  end
end
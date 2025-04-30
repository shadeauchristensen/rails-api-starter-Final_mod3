require 'rails_helper'

RSpec.describe 'Api::V1::Schedule', type: :request do
  describe 'DELETE /api/v1/schedules/:schedule_id/shows/:id' do
    let!(:schedule) { Schedule.create!(title: 'Test Festival', date: '2025-07-10') }
    let!(:show) do
      schedule.shows.create!(
        artist: 'Test Band',
        location: 'Main Stage',
        date: '2025-07-10',
        time: '18:00'
      )
    end

    it 'removes a show from the schedule' do
      delete "/api/v1/schedules/#{schedule.id}/shows/#{show.id}"

      expect(response).to have_http_status(:no_content)
      expect(schedule.shows).not_to include(show)
    end

    it 'includes full show info in each schedule' do
      schedule = Schedule.create!(title: 'Test Fest', date: '2025-07-10')
      schedule.shows.create!(
        artist: 'Sleep Token',
        location: 'Main Stage',
        date: '2025-07-10',
        time: '21:00'
      )
    
      get '/api/v1/schedules'
      json = JSON.parse(response.body, symbolize_names: true)
      shows = json[:data].first[:attributes][:shows]
    
      expect(shows).to be_an(Array)
      expect(shows.first).to include(:id, :artist, :location, :date, :time)
    end

    it 'returns 404 if the show does not belong to the schedule' do
      schedule = Schedule.first
      unrelated_show = Show.create!(
        artist: 'Unrelated Band',
        location: 'Backstage',
        date: '2025-07-09',
        time: '23:00'
      )

      delete "/api/v1/schedules/#{schedule.id}/shows/#{unrelated_show.id}"

      expect(response).to have_http_status(:not_found)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:error]).to eq('Schedule or Show not found')
    end
  end
end
class Api::V1::ShowsController < ApplicationController
    def create
        schedule = Schedule.find(params[:schedule_id])
        show = schedule.shows.create!(show_params)

        render json: ShowSerializer.new(show), status: :created 
    end

    private

    def show_params
        params.require(:show).permit(:artist, :location, :date, :time)
    end
end

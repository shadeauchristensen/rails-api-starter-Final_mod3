class Api::V1::ShowsController < ApplicationController
    def create
        schedule = Schedule.find(params[:schedule_id])
        show = schedule.shows.create!(show_params)

        render json: ShowSerializer.new(show), status: :created 
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'Schedule not found' }, status: :not_found
    rescue ActiveRecord::RecordInvalid => error
        render json: { error: error.message }, status: :unprocessable_entity
    end

    private

    def show_params
        params.require(:show).permit(:artist, :location, :date, :time)
    end
end

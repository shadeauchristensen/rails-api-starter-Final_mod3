class Api::V1::SchedulesController < ApplicationController

    def index
        schedules = Schedule.includes(:users, :shows)

        render json: ScheduleSerializer.new(schedules).serializable_hash
    end

    def destroy
        schedule = Schedule.find(params[:schedule_id])
        show = schedule.shows.find(params[:id])

        schedule.shows.destroy(show)
        head :no_content # using to get 204 status code 
    end
end

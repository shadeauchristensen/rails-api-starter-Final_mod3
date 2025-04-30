class Api::V1::SchedulesController < ApplicationController

    def index
        schedules = Schedule.includes(:users, :shows)

        render json: ScheduleSerializer.new(schedules).serializable_hash
    end

    def show
        schedule = Schedule.includes(:shows, :users).find(params[:id])
        render json: ScheduleSerializer.new(schedule).serializable_hash
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Schedule not found" }, status: :not_found
    end

    def destroy
        schedule = Schedule.find(params[:schedule_id])
        show = schedule.shows.find(params[:id])

        schedule.shows.destroy(show)
        head :no_content # using to get 204 status code 
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'Schedule or Show not found' }, status: :not_found
    end
end

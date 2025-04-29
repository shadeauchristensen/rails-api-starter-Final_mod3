class Api::V1::SchedulesController < ApplicationController

    def index
        schedules = Schedule.includes(:users, :shows)

        render json: ScheduleSerializer.new(schedules).serializable_hash
    end
end

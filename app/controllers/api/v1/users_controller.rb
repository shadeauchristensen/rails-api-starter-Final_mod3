class Api::V1::UsersController < ApplicationController
    def show 
        user = User.includes(schedules: [:shows]).find(params[:id])

        render json: UserSerializer.new(user, include: ['schedules', 'schedules.shows']).serializable_hash
    end
end

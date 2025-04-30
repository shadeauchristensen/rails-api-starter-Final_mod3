class Api::V1::UsersController < ApplicationController
    def show 
        user = User.includes(schedules: [:shows]).find(params[:id])

        render json: UserSerializer.new(user, include: ['schedules', 'schedules.shows']).serializable_hash

    rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
    end
end

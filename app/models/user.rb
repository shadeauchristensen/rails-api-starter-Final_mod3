class User < ApplicationRecord
    has_many :schedule_users
    has_many :schedules, through: :schedule_users
end
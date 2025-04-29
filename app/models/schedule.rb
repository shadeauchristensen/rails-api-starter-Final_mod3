class Schedule < ApplicationRecord
    has_many :schedule_users
    has_many :users, through: :schedule_users
  
    has_many :schedule_shows
    has_many :shows, through: :schedule_shows
end

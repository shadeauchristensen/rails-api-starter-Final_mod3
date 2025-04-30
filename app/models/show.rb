class Show < ApplicationRecord
    validates :artist, presence: true
    validates :location, presence: true

    has_many :schedule_shows
    has_many :schedules, through: :schedule_shows
end
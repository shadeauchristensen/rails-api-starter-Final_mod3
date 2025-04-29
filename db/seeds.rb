# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Destroy all Users, Shows, Schedules, ScheduleUsers, ScheduleShows

ScheduleUser.destroy_all
ScheduleShow.destroy_all
User.destroy_all
Show.destroy_all
Schedule.destroy_all



friday = Schedule.create!(title: "Friday Festival", date: Date.new(2025, 7, 5))
saturday = Schedule.create!(title: "Saturday Festival", date: Date.new(2025, 7, 6))
sunday = Schedule.create!(title: "Sunday Festival", date: Date.new(2025, 7, 7))

band_list = [
  "Wage War", "Thrown", "Abbie Falls", "Sleep Theory",
  "Bilmuri", "The Plot In You", "I Prevail", "Korn",
  "Headwreck", "Bury Tomorrow", "DEADSKIN", "Architects"
]

show_times = ["4:00 PM", "5:30 PM", "7:00 PM", "8:30 PM"]
locations = ["Main Stage", "Side Stage"]

bands_per_day = band_list.each_slice(4).to_a

[friday, saturday, sunday].each_with_index do |schedule, index|
    bands_per_day[index].each_with_index do |band, time_index|
        show = Show.create!(
        artist: band,
        location: locations.sample,
        date: schedule.date,
        time: show_times[time_index]
        )
        ScheduleShow.create!(schedule: schedule, show: show)
    end
end

10.times do
    User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.unique.email
    )
end

all_users = User.all

[friday, saturday, sunday].each do |schedule|
    selected_users = all_users.sample(rand(3..5)) # 3 to 5 users per day
    selected_users.each do |user|
        ScheduleUser.create!(schedule: schedule, user: user)
    end
end

puts " Seeding complete!"
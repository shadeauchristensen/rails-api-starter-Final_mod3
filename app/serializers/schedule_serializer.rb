class ScheduleSerializer
  include JSONAPI::Serializer

  attributes :title, :date

  attribute :users do |schedule|
    schedule.users.map do |user|
      {
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email
      }
    end
  end

  attribute :shows do |schedule|
    schedule.shows.map do |show|
      {
        id: show.id,
        artist: show.artist,
        location: show.location,
        date: show.date,
        time: show.time
      }
    
    end
  end
end
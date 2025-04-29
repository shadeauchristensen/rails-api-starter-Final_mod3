class ScheduleSerializer
  include JSONAPI::Serializer

  attributes :title, :date

  has_many :users

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
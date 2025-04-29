class ScheduleSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :date

  has_many :users
  has_many :shows
end

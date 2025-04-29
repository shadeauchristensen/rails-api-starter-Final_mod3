class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :first_name, :last_name, :email

  has_many :schedules
end

require 'rails_helper'

RSpec.describe Show, type: :model do
  describe 'relationships' do
    it { should have_many :schedule_shows }
    it { should have_many(:schedules).through(:schedule_shows) }
  end
end

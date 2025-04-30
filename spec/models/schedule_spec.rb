require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'relationships' do
    it { should have_many :schedule_users }
    it { should have_many(:users).through(:schedule_users) }

    it { should have_many :schedule_shows }
    it { should have_many(:shows).through(:schedule_shows) }
  end
end

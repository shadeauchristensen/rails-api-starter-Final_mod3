require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :schedule_users }
    it { should have_many(:schedules).through(:schedule_users) }
  end
end

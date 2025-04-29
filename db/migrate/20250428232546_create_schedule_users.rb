class CreateScheduleUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :schedule_users do |t|
      t.references :schedule, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

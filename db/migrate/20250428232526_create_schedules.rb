class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.string :title
      t.date :date

      t.timestamps
    end
  end
end

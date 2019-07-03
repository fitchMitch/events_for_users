class ChangeColumnDurationToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :end_time, :datetime, null: false, default: Time.zone.now
    remove_column :events, :sec_duration, :integer, null: false, default: 0
  end
end

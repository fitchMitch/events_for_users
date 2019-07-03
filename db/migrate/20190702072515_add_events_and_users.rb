class AddEventsAndUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :description, null: true
      t.string :location, index: true
      t.datetime :start_time, null: false, default: Time.zone.now
      t.integer :sec_duration, default: 0
      t.timestamps
    end

    create_table :users do |t|
      t.string :name
      t.timestamps
    end

    create_table :events_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :event, index: true
    end
  end
end

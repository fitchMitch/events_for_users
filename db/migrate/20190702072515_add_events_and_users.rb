class AddEventsAndUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :location, index: true
      t.datetime :start_time
      t.integer :sec_duration
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

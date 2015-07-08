class CreateSecureMeetings < ActiveRecord::Migration
  def change
    create_table :secure_meetings, id: false do |t|
      t.primary_key :identifier
      t.date :starts_at
      t.date :ends_at
      t.timestamps
    end
  end
end

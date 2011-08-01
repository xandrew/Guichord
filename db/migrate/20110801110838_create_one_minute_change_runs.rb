class CreateOneMinuteChangeRuns < ActiveRecord::Migration
  def self.up
    create_table :one_minute_change_runs do |t|
      t.integer :user_id
      t.integer :first_chord_id
      t.integer :second_chord_id
      t.integer :num_changes

      t.timestamps
    end
  end

  def self.down
    drop_table :one_minute_change_runs
  end
end

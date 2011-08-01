class RefactorOneMinteChanges < ActiveRecord::Migration
  def self.up
    remove_column(:one_minute_change_runs, :first_chord_id)
    remove_column(:one_minute_change_runs, :second_chord_id)
    add_column(:one_minute_change_runs, :chord_pair_id, :integer)
  end

  def self.down
    remove_column(:one_minute_change_runs, :chord_pair_id)
    add_column(:one_minute_change_runs, :second_chord_id, :integer)
    add_column(:one_minute_change_runs, :first_chord_id, :integer)
  end
end

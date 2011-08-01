class CreateChordPairs < ActiveRecord::Migration
  def self.up
    create_table :chord_pairs do |t|
      t.integer :first_chord_id
      t.integer :second_chord_id

      t.timestamps
    end
  end

  def self.down
    drop_table :chord_pairs
  end
end

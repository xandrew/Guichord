class CreateChords < ActiveRecord::Migration
  def self.up
    create_table :chords do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :chords
  end
end

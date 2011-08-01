class ChordPair < ActiveRecord::Base
  belongs_to :first_chord, :class_name => "Chord"
  belongs_to :second_chord, :class_name => "Chord"
end

class OneMinuteChangeRunsController < ApplicationController
  def new
    @one_minute_change_run = OneMinuteChangeRun.new
  end

  def create
    @one_minute_change_run = OneMinuteChangeRun.new(params[:one_minute_change_run])
    chord1 = Chord.where(:name => params[:first_chord_name]).first
    chord2 = Chord.where(:name => params[:second_chord_name]).first
    if chord1.id > chord2.id
      chord1, chord2 = chord2, chord1
    end
    pair = ChordPair.where(:first_chord_id => chord1.id, :second_chord_id => chord2.id).first
    if not pair
      pair = ChordPair.create(:first_chord_id => chord1.id, :second_chord_id => chord2.id)
    end
    @one_minute_change_run.chord_pair = pair
    @one_minute_change_run.user = User.find(1)
    @one_minute_change_run.save
  end

end

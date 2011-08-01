class ListRunsController < ApplicationController
  def list
    user = User.find(1)

    @user_id = user.id

    max_changes_per_pair = OneMinuteChangeRun.where(:user_id => user.id).group(:chord_pair_id).maximum(:num_changes)

    @change_stats = []
    max_changes_per_pair.each do |pair, max_changes|
      last_run = OneMinuteChangeRun.where(:user_id => user.id, :chord_pair_id => pair).order(:created_at).last
      @change_stats << {
        :pair => ChordPair.find(pair),
        :max => max_changes,
        :last_run => last_run
      }
    end
    @change_stats.sort! { |a, b| a[:max] - b[:max] }

    @chords = Chord.all
  end
end

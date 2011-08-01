class OneMinuteChangeRun < ActiveRecord::Base
  belongs_to :user
  belongs_to :chord_pair
end

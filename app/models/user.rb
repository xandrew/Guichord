class User < ActiveRecord::Base
  has_many :one_minute_change_runs
end

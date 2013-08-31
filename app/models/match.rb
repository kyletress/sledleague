class Match < ActiveRecord::Base
  attr_accessible :league_id, :race_id

  belongs_to :league
  belongs_to :race
end

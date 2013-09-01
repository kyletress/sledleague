class Match < ActiveRecord::Base
  attr_accessible :league_id, :race_id, :predictions_attributes

  belongs_to :league
  belongs_to :race
  has_many :predictions
end

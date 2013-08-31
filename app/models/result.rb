class Result < ActiveRecord::Base
  attr_accessible :athlete_id, :position, :race_id
  belongs_to :race
  belongs_to :athlete
end

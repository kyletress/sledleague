class Athlete < ActiveRecord::Base
  attr_accessible :name
  has_many :results
  has_many :predictions

  def result(race_id)
  	Result.find_by_athlete_id_and_race_id(self.id, race_id).position
  end
end

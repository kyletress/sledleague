class Athlete < ActiveRecord::Base
  attr_accessible :name
  has_many :results

  validates :name, presence: true

  def result(race_id)
  	Result.find_by_athlete_id_and_race_id(self.id, race_id).position
  end

  def self.search(search)
  	if search
  		where('name LIKE ?', "%#{search}%")
  	else
  		scoped
  	end
  end
end

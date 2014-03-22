class Result < ActiveRecord::Base
  attr_accessible :athlete_id, :position, :race_id, :athlete_name
  belongs_to :race
  belongs_to :athlete

  validates :athlete_id, :race_id, :position, presence: true
  
  def athlete_name
    athlete.try(:name)
  end
  
  def athlete_name=(name)
    self.athlete = Athlete.find_by_name(name) if name.present?
  end
end

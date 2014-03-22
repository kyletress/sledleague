class Pick < ActiveRecord::Base
  attr_accessible :athlete_id, :position, :prediction_id, :points, :athlete_name
  belongs_to :prediction
  belongs_to :athlete

  # validates_uniqueness_of :athlete_id, :scope => :prediction_id BUG IN RAILS
  validates :athlete_id, :position, presence: true
  validate :ensure_unique_athlete_per_prediction

  # Homemade validation to fix the rails uniqueness nested scope validation bug
  def ensure_unique_athlete_per_prediction
  	errors.add(:athlete_id, "Already chosen") if @duplicate_athlete_ids.present? and @duplicate_athlete_ids.include?(athlete_id)
	end
  
  def athlete_name
    athlete.try(:name)
  end
  
  def athlete_name=(name)
    self.athlete = Athlete.find_by_name(name) if name.present?
  end

  def calculate_points(result)
    score = 0
    x = (result.position - self.position).abs
    case x
    when 0
      score = 3
    when 1
      score = 2
    when 2
      score = 1
    else
      score = 0
    end
    self.update_attributes(:points => score)
  end
end
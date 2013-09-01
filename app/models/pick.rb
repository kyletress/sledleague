class Pick < ActiveRecord::Base
  attr_accessible :athlete_id, :position, :prediction_id
  belongs_to :prediction
  belongs_to :athlete

  # validates_uniqueness_of :athlete_id, :scope => :prediction_id
  validates :athlete_id, :position, presence: true

  validate :ensure_unique_athlete_per_prediction

  def ensure_unique_athlete_per_prediction
  	errors.add(:athlete_id, "Already chosen") if @duplicate_athlete_ids.present? and @duplicate_athlete_ids.include?(athlete_id)
	end
end

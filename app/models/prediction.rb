class Prediction < ActiveRecord::Base
  attr_accessible :match_id, :user_id, :picks_attributes

  belongs_to :match
  belongs_to :user
  belongs_to :membership
  has_many :picks, dependent: :destroy

  accepts_nested_attributes_for :picks

  validates_uniqueness_of :user_id, :scope => :match_id
  validates :match_id, :user_id, presence: true

  # Homemade validation to fix bug in rails uniqueness nested scope validation
	before_validation do
    picks.map do |e|
      athlete_ids = picks.collect(&:athlete_id).compact
      athlete_ids_counted = athlete_ids.inject({}) { |hash,athlete_id| hash[athlete_id] = (hash[athlete_id] || 0) + 1; hash }
      duplicate_athlete_ids = athlete_ids_counted.select { |k,v| v > 1 }.keys
      e.instance_variable_set "@duplicate_athlete_ids", duplicate_athlete_ids
    end
  end

  # TODO
  # Can edit predictions until 1 hour before the match begins.
  # Then lock the prediction.
  # Can't make predictions new predictions for completed race.
  # Can only see predictions within my league

end

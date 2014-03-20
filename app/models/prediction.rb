class Prediction < ActiveRecord::Base
  attr_accessible :match_id, :user_id, :picks_attributes, :total_points, :membership_id

  belongs_to :match
  belongs_to :user
  belongs_to :membership
  has_many :picks, dependent: :destroy

  accepts_nested_attributes_for :picks

  validates_uniqueness_of :user_id, :scope => :match_id
  validates :match_id, :user_id, presence: true
  # before_create :race_not_completed

  # Homemade validation to fix bug in rails uniqueness nested scope validation
	before_validation do
    picks.map do |e|
      athlete_ids = picks.collect(&:athlete_id).compact
      athlete_ids_counted = athlete_ids.inject({}) { |hash,athlete_id| hash[athlete_id] = (hash[athlete_id] || 0) + 1; hash }
      duplicate_athlete_ids = athlete_ids_counted.select { |k,v| v > 1 }.keys
      e.instance_variable_set "@duplicate_athlete_ids", duplicate_athlete_ids
    end
  end

  def calculate_points
    score = 0 # full points
    pick_score = 0 # breakdown points
    picks.each do |pick|
      # BUG? - What if the predicted pick doesn't have a result? Need to account for this.
      x = (pick.athlete.result(pick.prediction.match.race.id) - pick.position).abs
      case x
      when 0
        score = score + 3
        pick_score = 3
      when 1
        score = score + 2
        pick_score = 2
      when 2
        score = score + 1
        pick_score = 1
      else
        score = score + 0
        pick_score = 0
      end
      pick.update_attributes(:points => pick_score)
    end
    self.update_attributes(:total_points => score)
  end

  # TODO
  # URGENT - Predictions should belong to a member, not a user.
  # Can edit predictions until 1 hour before the match begins.
  # Then lock the prediction.
  # Can't make new predictions for completed race.
  # Can only see predictions within my league
end

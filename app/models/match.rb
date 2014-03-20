class Match < ActiveRecord::Base
  attr_accessible :league_id, :race_id, :predictions_attributes

  belongs_to :league
  belongs_to :race
  has_many :predictions, dependent: :destroy

  validates :league_id, :race_id, presence: true
 
  def predictions_closed
    cutoff = TimeDifference.between(race.startdate, Time.now).in_minutes
    if cutoff < 45 || race.completed
      return true
    else
      return false
    end
  end
end

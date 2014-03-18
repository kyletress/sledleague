class Match < ActiveRecord::Base
  attr_accessible :league_id, :race_id, :predictions_attributes

  belongs_to :league
  belongs_to :race
  has_many :predictions, dependent: :destroy

  validates :league_id, :race_id, presence: true

  def predictions_closed
    cutoff = race.startdate - 1.hour # Hardcoded, but could easily be a league setting
  	if Time.now >= cutoff
  		return true
  	else
  		return false
  	end
  end
end

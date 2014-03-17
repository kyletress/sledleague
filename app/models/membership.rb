class Membership < ActiveRecord::Base
  attr_accessible :league_id, :user_id, :team
  belongs_to :user
  belongs_to :league
  has_many :predictions

  validates_uniqueness_of :user_id, :scope => :league_id
  before_destroy :ensure_not_league_manager

  # TODO - Validate the uniqueness of the name string within each league.

  # Thinking of improving this model by adding a Team Name and
  # Total Points. Then I can also mark a Champion field (BOOLEAN)
  # The show page will act as a team page, visible to all other
  # peeps in the league.
  # TODO - Bolster this model to include team name, team page, and total points

  def team_points
  	self.predictions.sum(:total_points)
  end

  def team_name
		if self.team.present?
			return self.team
		else
			return self.user.email
		end
	end

  private

  # Need to improve error display with this validation
  def ensure_not_league_manager
    if user == league.manager
      errors.add(:base, "Managers can't leave their leagues")
      logger.error "Manager tried to leave league"
      return false
    else
      return true
    end
  end


end

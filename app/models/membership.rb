class Membership < ActiveRecord::Base
  attr_accessible :league_id, :user_id
  belongs_to :user
  belongs_to :league
  belongs_to :invitation

  validates_uniqueness_of :user_id, :scope => :league_id

  # Thinking of improving this model by adding a Team Name and
  # Total Points. Then I can also mark a Champion field (BOOLEAN)
  # The show page will act as a team page, visible to all other
  # peeps in the league.

end

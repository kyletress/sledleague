class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :memberships, dependent: :destroy
  has_many :leagues, through: :memberships
  has_many :predictions, dependent: :destroy
  # has_many :invitations, dependent: :nullify # just set the user_id to null

  def is_member(league)
    if self.memberships.find_by_league_id(league.id)
      return true
    else
      return false
    end
  end
  
  def current_team(league)
    Membership.find_by_user_id_and_league_id(self.id, league.id)
  end

  def is_manager(league)
    self == league.manager
  end

  def has_prediction?(match)
    self && self.predictions.find_by_match_id(match.id)
  end

  def points(match)
    if match && match.race.results.present?
      total = 0
      prediction = self.predictions.find_by_match_id(match.id)
      if prediction # not all matches have predictions
        for pick in prediction.picks
          x = (pick.athlete.result(match.race.id) - pick.position).abs
          case x
          when 0
            total = total + 3
          when 1
            total = total + 2
          when 2
            total = total + 1
          else
            total = total + 0
          end
        end
      end
      return total
    else
      return 0
    end
  end

  def total_points(league)
    total = 0
    for match in league.matches
      total = total + self.points(match)
    end
    return total
  end
end

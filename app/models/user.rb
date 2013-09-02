class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :memberships
  has_many :leagues, through: :memberships
  has_many :predictions

  def is_member(league)
    if self.memberships.find_by_league_id(league.id)
      return true
    else
      return false
    end
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

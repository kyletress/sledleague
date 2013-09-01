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
end

class Prediction < ActiveRecord::Base
  attr_accessible :athlete_id, :match_id, :user_id, :position

  belongs_to :match
  belongs_to :user
  belongs_to :athlete

  validates_uniqueness_of :user_id, :scope => :match_id
  validates :match_id, presence: true
end

class Membership < ActiveRecord::Base
  attr_accessible :league_id, :user_id
  belongs_to :user
  belongs_to :league

  validates_uniqueness_of :user_id, :scope => :league_id
end

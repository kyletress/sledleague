class League < ActiveRecord::Base
  attr_accessible :manager_id, :name, :race_ids, :max_teams, :private, :max_matches
  belongs_to :manager, :class_name => 'User', :foreign_key => 'manager_id'

  has_many :memberships
  has_many :users, through: :memberships, :uniq => true
  has_many :matches
  has_many :races, through: :matches
end

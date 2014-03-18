class League < ActiveRecord::Base
  attr_accessible :manager_id, :name, :race_ids, :max_teams, :private, :max_matches

  belongs_to :manager, :class_name => 'User', :foreign_key => 'manager_id'
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :matches, dependent: :destroy
  has_many :races, through: :matches
  has_many :results, through: :races
  has_many :invitations

  validates :manager_id, :name,
  					presence: true

  validates :name, length: { in: 5..30 }
  validates :name, uniqueness: true

  # TODO - Proper league settings model
  # every league gets a default setting. 8 races, 8 teams, 1 hour cutoff. Scoring. Then you can tweak it


end

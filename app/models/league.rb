class League < ActiveRecord::Base
  attr_accessible :manager_id, :name, :race_ids
  belongs_to :manager, :class_name => 'User', :foreign_key => 'manager_id'

  has_many :memberships
  has_many :users, through: :memberships
  has_many :matches
  has_many :races, through: :matches
end

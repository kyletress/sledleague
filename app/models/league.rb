class League < ActiveRecord::Base
  attr_accessible :manager_id, :name
  belongs_to :manager, :class_name => 'User', :foreign_key => 'manager_id'

  has_many :memberships
  has_many :users, through: :memberships
end

class Race < ActiveRecord::Base
  attr_accessible :name, :startdate

  has_many :matches
  has_many :leagues, through: :matches
end

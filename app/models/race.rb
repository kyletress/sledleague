class Race < ActiveRecord::Base
  attr_accessible :name, :startdate, :results_attributes

  has_many :matches
  has_many :leagues, through: :matches
  has_many :results
  accepts_nested_attributes_for :results
end

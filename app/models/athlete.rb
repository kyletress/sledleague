class Athlete < ActiveRecord::Base
  attr_accessible :name
  has_many :results
  has_many :predictions
end

class Race < ActiveRecord::Base
  attr_accessible :name, :startdate, :results_attributes

  has_many :matches, dependent: :destroy
  has_many :leagues, through: :matches
  has_many :results, dependent: :destroy
  accepts_nested_attributes_for :results

  validates :name, presence: true
end

class Race < ActiveRecord::Base
  attr_accessible :name, :startdate, :completed
  after_save :go_for_points

  has_many :matches, dependent: :destroy
  has_many :leagues, through: :matches
  has_many :results, dependent: :destroy
  accepts_nested_attributes_for :results, :reject_if => lambda { |a| a[:athlete_id].blank? }

  validates :name, presence: true

  def go_for_points
  	if completed && results.present?
  		self.matches.each do |match|
  			match.predictions.each do |prediction|
  				prediction.calculate_points
          ResultsMailer.results_email(prediction).deliver
  			end
  		end
  	else
  		return
  	end
  end
end

class AthletesController < ApplicationController
	def index
		@athletes = Athlete.search(params[:search]).order
		@random_athlete = Athlete.offset(rand(Athlete.count)).first
	end

	def new
		@athlete = Athlete.new
	end

	def show
		@athlete = Athlete.find(params[:id])
	end

	def edit
		@athlete = Athlete.find(params[:id])
	end

	def create
		@athlete = Athlete.new(params[:athlete])
		if @athlete.save
			redirect_to @athlete
		else
			render 'new'
		end
	end
end

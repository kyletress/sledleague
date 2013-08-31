class AthletesController < ApplicationController
	def index
		@athletes = Athlete.all
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

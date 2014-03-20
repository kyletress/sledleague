class AthletesController < ApplicationController
  before_filter :admin_user, except: [:index, :show]
  
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
      redirect_to athletes_path
		else
			render 'new'
		end
	end
  
  def update
    @athlete = Athlete.find(params[:id])
    if @athlete.update_attributes(params[:athlete])
      redirect_to @athlete
    else
      render 'edit'
    end
  end
  
  private
    
    def admin_user
      redirect_to root_url, notice: 'Only admin users can do that' unless current_user && current_user.admin? # TODO show a 404 here instead
    end
end

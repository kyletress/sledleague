class RacesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :admin_user, except: [:index, :show]

  def index
  	@races = Race.all
  end

  def show
  	@race = Race.find(params[:id])
  end

  def new
  	@race = Race.new
  end

  def edit
  	@race = Race.find(params[:id])
    if @race.results.blank?
      12.times {|n| @race.results.build(:position => n+1) }
      # TODO - Full results. Autocomplete text field. Ajax. 
    end
  end

  def create
  	@race = Race.create(params[:race])
  	if @race.save
  		redirect_to @race
  	else
  		render 'new'
  	end
  end

  def update
    @race = Race.find(params[:id])
    if @race.update_attributes(params[:race])
      redirect_to @race
    else
      render 'edit'
    end
  end
  
  private
  
    def admin_user
      redirect_to root_url, notice: 'Only admin users can do that' unless current_user && current_user.admin? # TODO show a 404 here instead
    end
end

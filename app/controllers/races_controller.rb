class RacesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

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
  end

  def create
  	@race = Race.create(params[:race])
  	if @race.save
  		redirect_to @race
  	else
  		render 'new'
  	end
  end
end

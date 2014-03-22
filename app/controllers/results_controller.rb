class ResultsController < ApplicationController
  before_filter :load_race
  
  def index
    @results = @race.results.order("position")
    @result = @race.results.build
  end
  
  def create
    @result = @race.results.build(params[:result])
    if @result.save
      respond_to do |format|
        format.html { redirect_to race_results_path}
        format.js
      end
    else
      render 'index', notice: 'Result could not be added'
    end
  end
  
  def destroy
    @result = @race.results.find(params[:id])
    @result.destroy
    respond_to do |format|
      format.html { redirect_to race_results_path(@race), notice: 'Result destroyed' }
      format.js
    end 
  end
  
  private
  
  def load_race
    @race = Race.find(params[:race_id])
  end
 
end

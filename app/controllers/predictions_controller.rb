class PredictionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_user
  before_filter :load_match
  # TODO - Only league members can make or see predictions
  # Maybe make a validation on prediction model instead of checking in controller.

  def index
    @predictions = @match.predictions
  end

  def new
    if @match.race.completed?
      redirect_to @match, notice: 'Predictions are closed for this race!'
    else
      if @user.is_member(@match.league)
        @prediction = @match.predictions.build(:user_id => current_user)
        10.times {|n| @prediction.picks.build(:position => n + 1) }
    	else
        redirect_to current_user.leagues.first # what if a current user doesn't have a league?
    		flash[:notice] = 'You are not a members of that league!'
    	end
    end
  end

  def show
  	@prediction = Prediction.find(params[:id])
  end

  def edit
    @prediction = Prediction.find(params[:id])
  end
  
  def update
    @prediction = Prediction.find(params[:id])
    if @prediction.update_attributes(params[:prediction])
      redirect_to match_prediction_path(@match, @prediction), notice: 'Prediction updated'
    else
      render 'edit'
    end
  end

  def create
  	@prediction = @match.predictions.new(params[:prediction])
  	if @prediction.save
  		redirect_to match_prediction_path(@match, @prediction), notice: 'Prediction saved!'
  	else
  		render 'new'
  	end
  end
  
  def destroy
    @prediction = Prediction.find(params[:id])
    @prediction.destroy
    redirect_to @match
  end

  private

    def load_user
  		@user = current_user
  	end

    def load_match
      @match = Match.find(params[:match_id])
    end
end

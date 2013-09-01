class PredictionsController < ApplicationController

  before_filter :load_user

  def new
  	@match = Match.find(params[:match_id])
  	if @user.is_member(@match.league)
  		@prediction = @user.predictions.build(:match_id => @match.id)
  	else
  		redirect_to current_user.leagues.first
  		flash[:notice] = 'You are not a members of that league!'
  	end
  end

  def show
  end

  def edit
  end

  def create
  	@prediction = @user.predictions.new(params[:prediction])
  	if @prediction.save
  		redirect_to @prediction
  	else
  		render 'new'
  	end
  end

  private
  	def load_user
  		@user = current_user
  	end
end

class PredictionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_user
  before_filter :league_member

  def new
  	@match = Match.find(params[:match_id])
  	if @user.is_member(@match.league)
  		@prediction = @user.predictions.build(:match_id => @match.id)
  		10.times {|n| @prediction.picks.build(:position => n+1) }
  		#do @prediction.picks.build
  		#end
  	else
  		redirect_to current_user.leagues.first
  		flash[:notice] = 'You are not a members of that league!'
  	end
  end

  def show
  	@prediction = Prediction.find(params[:id])
  end

  def edit
  end

  def create
  	@prediction = @user.predictions.new(params[:prediction])
  	if @prediction.save
  		redirect_to @prediction, notice: 'Prediction saved!'
  	else
  		render 'new'
  	end
  end

  private
  	def load_user
  		@user = current_user
  	end

    def league_member
      @prediction = Prediction.find(params[:id])
      @league = @prediction.match.league
      redirect_to(root_path) if @league.memberships.find_by_user_id(current_user.id).nil?
    end
end

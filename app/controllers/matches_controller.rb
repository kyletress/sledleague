class MatchesController < ApplicationController
  before_filter :authenticate_user!

  def show
  	@match = Match.find(params[:id])
  	if current_user && current_user.has_prediction?(@match)
  		@prediction = current_user.predictions.find_by_match_id(@match.id)
  		#@prediction = current_user.memberships.find_by_league_id(@match.league.id)
  	end
  end
end

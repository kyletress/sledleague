class MatchesController < ApplicationController
  def show
  	@match = Match.find(params[:id])
  	if current_user && current_user.has_prediction?(@match)
  		@prediction = current_user.predictions.find_by_match_id(@match.id)
  	end
  end
end

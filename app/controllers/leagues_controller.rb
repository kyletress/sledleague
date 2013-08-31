class LeaguesController < ApplicationController

  before_filter :authenticate_user!, except: [:index]

  def index
  	@leagues = League.all
  end

  def show
  	@league = League.find(params[:id])
  end

  def new
  	@league = League.new
  end

  def edit
  	@league = League.find(params[:id])
  end

  def create
  	@league = League.new(params[:league])
  	if @league.save
  		current_user.memberships.create(:league_id => @league.id)
  		redirect_to @league
  	else
  		render 'new'
  	end
  end

  def update
    @league = League.find(params[:id])
    if @league.update_attributes(params[:league])
      redirect_to @league
    else
      render 'edit'
    end
  end
end

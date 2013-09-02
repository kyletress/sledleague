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

  def destroy
    @league = League.find(params[:id])
    @league.destroy
    redirect_to leagues_path
  end

  def join
    @league = League.find(params[:id])
    if current_user.memberships.create(:league_id => @league.id)
      redirect_to @league
    else
      render @league, notice: 'You are already in this league'
    end
  end

  def leave
    @league = League.find(params[:id])
    current_user.memberships.find_by_league_id(@league.id).destroy
    redirect_to @league
  end
end

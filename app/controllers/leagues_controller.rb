class LeaguesController < ApplicationController

  before_filter :authenticate_user!, except: [:index]
  before_filter :league_member, :except => [:index, :new, :create, :join]
  before_filter :league_manager, only: [:edit, :update, :destroy]

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
    if current_user && current_user.leagues.count < 3
      if current_user.memberships.create(:league_id => @league.id)
        redirect_to @league, notice: 'Welcome to the league'
      else
        render @league, notice: 'You are already a member'
      end
    else
      redirect_to leagues_path, notice: "You have already joined the maximum number of leagues"
    end
  end

  def leave
    @league = League.find(params[:id])
    if @league.manager == current_user
      redirect_to @league, notice: 'Managers cannot leave their league'
    else
      current_user.memberships.find_by_league_id(@league.id).destroy
      redirect_to leagues_path
    end
  end

  def accept_invitation
    @league = League.find(params[:id])
    current_user.memberships.create(:league_id => @league.id)
    redirect_to @league, notice: 'Welcome to the league'
  end

  private

    def league_member
      @league = League.find(params[:id])
      if @league.private && @league.memberships.find_by_user_id(current_user.id).nil?
        redirect_to(root_path) unless current_user == @league.manager
      end
    end

    def league_manager
      @league = League.find(params[:id])
      redirect_to @league unless current_user == @league.manager
    end
end

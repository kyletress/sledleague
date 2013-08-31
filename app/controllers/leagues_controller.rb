class LeaguesController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]

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
  end
end

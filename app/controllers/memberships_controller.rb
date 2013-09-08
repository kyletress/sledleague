class MembershipsController < ApplicationController

  before_filter :load_membership, except: [:create, :new]
  before_filter :correct_user, only: [:edit, :update]

  def new
    # Probably don't need this unless I want Team Name
  end

  def show
  end

  def edit
  end

  def update
  	if @membership.update_attributes(params[:membership])
  		redirect_to @membership, notice: 'Team updated'
  	else
  		render 'edit'
  	end
  end

  def create
    # Join league
  end

  def destroy
    # Leave league
    if @membership.destroy
      redirect_to leagues_url, notice: "Successfully left"
    else
      redirect_to @membership, notice: "#{@membership.errors[:base].to_s}"
    end
  end

  private

    def load_membership
      @membership = Membership.find(params[:id])
    end

    def correct_user
      @user = current_user
      redirect_to @membership.league unless @user == @membership.user
    end
end

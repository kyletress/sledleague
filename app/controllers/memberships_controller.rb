class MembershipsController < ApplicationController
  def new
  end

  def show
  	@membership = Membership.find(params[:id])
  end

  def edit
  	@membership = Membership.find(params[:id])
  end

  def update
  	@membership = Membership.find(params[:id])
  	if @membership.update_attributes(params[:membership])
  		redirect_to @membership, notice: 'Team updated'
  	else
  		render 'edit'
  	end
  end
end

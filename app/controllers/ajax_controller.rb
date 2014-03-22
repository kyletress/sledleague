class AjaxController < ApplicationController
  def index
    @athletes = Athlete.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @athletes.map(&:name)
  end
end

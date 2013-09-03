class InvitationsController < ApplicationController

	before_filter :load_league

	def new
		@invitation = Invitation.new
	end

	def create
		@invitation = Invitation.new(params[:invitation])
		@invitation.sender = current_user
		@invitation.league = @league
		if @invitation.save
			redirect_to leagues_url, notice: 'Successfully sent invitation'
		else
			render 'new'
		end
	end

	def accept
		if current_user
			@invitation = Invitation.find(params[:invitation_id])
			unless @invitation.recipient_email == current_user.email && @invitation.token == params[:token]
				redirect_to root_path
			end
		else
			redirect_to new_user_session_path
		end
	end

	private
		def load_league
			@league = League.find(params[:league_id])
		end
end

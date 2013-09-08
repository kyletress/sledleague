class InvitationsController < ApplicationController

	before_filter :load_league

	def index
		@invitations = @league.invitations.all
	end

	def new
		@invitation = Invitation.new
	end

	def create
		@invitation = Invitation.new(params[:invitation])
		@invitation.sender = current_user
		@invitation.league = @league
		if @invitation.save
			InvitationMailer.invite(@invitation).deliver
			redirect_to @league, notice: "Invitation sent. #{view_context.link_to('Send another?', new_league_invitation_path(@league))}".html_safe
		else
			render 'new'
		end
	end

	def destroy
		@invitation = Invitation.find(params[:id])
		@invitation.destroy
		redirect_to root_url, notice: 'You have declined the league invitation'
	end

	def accept
		@invitation = Invitation.find(params[:invitation_id])
		@user = User.find_by_email(@invitation.recipient_email)
		if @user # this person is registered
			unless current_user && @invitation.recipient_email == current_user.email && @invitation.token == params[:token]
				redirect_to root_path
			end
		else
		end
	end

	private
		def load_league
			@league = League.find(params[:league_id])
		end
end

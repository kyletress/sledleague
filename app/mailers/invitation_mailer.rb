class InvitationMailer < ActionMailer::Base
  default from: "noreply@fantasysliding.com"
  def invite(invitation)
  	@invitation = invitation
  	mail(:to => invitation.recipient_email, :subject => "Fantasy Sliding League Invitation", :from => "noreply@fantasysliding.com")
  end
end

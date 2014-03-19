class InvitationMailer < ActionMailer::Base
  default from: "kyle@fantasysliding.com"
  def invite(invitation)
  	@invitation = invitation
    mail(:to => invitation.recipient_email, :subject => "Fantasy Sliding League Invitation", :from => "kyle@fantasysliding.com")
  end
end

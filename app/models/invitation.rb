class Invitation < ActiveRecord::Base
  attr_accessible :league_id, :sender_id, :recipient_email, :sent_at, :token
  belongs_to :league
  belongs_to :sender, :class_name => 'User'

  validates :recipient_email, presence: true

  before_create :generate_token

  # TODO - Mark invitations as accepted. Necessary?
  # TODO - Invites should be unique within scope of league.
  # TODO - Non-registered users invited.
  # TODO - Only a league manager can invite players.

  def recipient_registered?
    if User.find_by_email(recipient_email)
      return true
    else
      return false
    end
  end

  private

  	def generate_token
  		self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  	end
end

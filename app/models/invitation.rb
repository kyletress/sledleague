class Invitation < ActiveRecord::Base
  attr_accessible :league_id, :sender_id, :recipient_email, :sent_at, :token
  belongs_to :league
  belongs_to :sender, :class_name => 'User'
  has_one :membership

  validates :recipient_email, presence: true

  before_create :generate_token

  private

  	def generate_token
  		self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  	end
end

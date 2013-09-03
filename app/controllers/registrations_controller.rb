class RegistrationsController < Devise::RegistrationsController
	def new
		super
		@user = User.new(:email => params[:email])
	end
end

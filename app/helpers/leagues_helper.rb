module LeaguesHelper
	def current_manager
		current_user == @league.manager
	end
end

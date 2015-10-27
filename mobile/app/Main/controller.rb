require 'rho/rhocontroller'

class MainController < Rho::RhoController

	def exit_app
		System.exit 
	end
	
	def back_callback
		""
	end

	def check_network
		render :string => "#{System.get_property('has_network')}"
	end
end
require 'rho/rhocontroller'

class BarcodeController < Rho::RhoController

	def scan_barcode
    Barcode.take_barcode(url_for(:action => :take_callback), {})
    render :back => "callback:" + url_for(:controller => "Main", :action => "back_callback")
	end
	
	def take_callback
		status = @params['status']
		barcode = @params['barcode']
		if status == 'ok'
			WebView.execute_js("scan_upc_callback('#{barcode}');")
		end
		if status == 'cancel' or status == 'back'
			WebView.execute_js("MyApp.app.getController('MainController').getMainTab().setActiveItem(0);")
		end
		""
	end
	
end
class CahpsExportDownloadController < ApplicationController

  def download
    send_file File.open("#{Rails.root}/tmp/CAHPS_#{params[:reference]}.csv")
  end
end
class OasisExportDownloadController < ApplicationController

  def download
    send_file File.open("#{Rails.root}/tmp/#{params[:reference]}.zip")
  end
end
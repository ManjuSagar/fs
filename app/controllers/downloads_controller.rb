class DownloadsController < ApplicationController

  def download_zip_file
    send_file File.open("#{Rails.root}/tmp/#{params[:reference]}.zip")
  end

  def download_file
    send_file "#{Rails.root}/tmp/#{params[:reference]}.#{params[:format]}", :filename => "#{params[:reference]}.#{params[:format]}"
  end

  def download_transmission_log_file
    transmission_log = MedicareClaimTransmissionLog.find(params[:id])
    file_path = transmission_log.claim_edi.path
    send_file file_path
  end

end
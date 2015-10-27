module Attachment

  def set_content_dispositon
    #self.options.merge({:s3_headers => {"Content-Disposition" => "attachment; filename="+self.sample_file_name}})
  end

  def set_defaults
    self.attachment_date = Date.current
  end

end
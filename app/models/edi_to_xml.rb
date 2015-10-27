module EDIToXML

  def edi_2_xml edi
    Rjb::load(ENV['CLASS_PATH'], [ENV['JVM_ARGS']]) unless Rjb::loaded?
    edi_2_xml_klass = Rjb::import('com.berryworks.edireader.demo.EDItoXML')
    input_file = nil
    output_file = nil
    begin
      input_file = Tempfile.new('edi')
      output_file = Tempfile.new('edixml')
      input_file.write edi
      input_file.close
      output_file.close
      edi_2_xml_klass.main([input_file.path, '-o', output_file.path])
      xml = File.read(output_file.path)
      File.open(File.join(ENV['HOME'], "last_edi_xml_#{Org.current.id}.xml"), 'w') {|f| f.puts xml} if Rails.env=="development"
      return xml
    ensure
      input_file.unlink if input_file
      output_file.unlink if output_file
    end
  end

end
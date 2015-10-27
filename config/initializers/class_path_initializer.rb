ENV['CLASS_PATH'] = ""
ENV['JVM_ARGS'] = "'-Djava.awt.headless=true','-Xms128M','-Xmx756M'"
require "jasper-rails"
workspace = "#{ENV['HOME']}/workspace"
http_client = Dir.glob("#{workspace}/http_client/lib/*")
docker_http_client = Dir.glob("/workspace/http-client/lib/*")
hhtp_client = http_client.present? ? http_client : docker_http_client
edi_reader = Dir.glob("#{workspace}/edireader/*.jar")
edi_reader = edi_reader.present? ? edi_reader : Dir.glob("/workspace/edireader/*.jar")
ENV['CLASS_PATH'] = (
					["#{JasperRails::Jasper::Rails.classpath}", "#{ProspectivePaymentSystem::HippscodeGenerator.classpath}",
											"#{Rails.root}/lib/poi-3.7-20101029.jar"] +
                    hhtp_client.collect{|f| "#{f}"} + 
                    ["#{Rails.root}/lib/MSFNAbility.jar"] +
                    edi_reader.collect{|f| "#{f}"}
                    ).join(":")
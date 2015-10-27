require "net/http"
require "uri"
require 'nokogiri'

class NPIToName
  attr_accessor :npi

  def initialize(npi)
    self.npi = npi
  end

  def get_name
    doc = Nokogiri::HTML(get_html_content) do |config|
      config.options = Nokogiri::XML::ParseOptions::NOBLANKS
    end
    doc.css('td')[1].text[2..-3]
  end

  def get_html_content
    uri = URI.parse("http://www.npinumberlookup.org/getResults.php")

    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({"npi" => self.npi})
    http.use_ssl = false
    response = http.request(request)
    response.body
  end

end


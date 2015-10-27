module NokogiriParseHelper
  include ActionView::Helpers::NumberHelper

  def get_nokogiri_document(xml_content)
    Nokogiri::XML(xml_content) do |config|
      config.options = Nokogiri::XML::ParseOptions::NOBLANKS
    end
  end

  def segment(parent, id)
    parent.css("segment[Id='#{id}']")
  end

  def segment_exists?(parent, id)
    segment(parent, id).size > 0
  end

  def loop(parent, id)
    parent.css("loop[Id='#{id}']")
  end

  def date_segment(ele = @nokogiri_doc)
    segment(ele, "DTM")
  end

  def ref_segments
    @nokogiri_doc.css("segment[Id='REF']")
  end

  def detect_item(arr, number, text = nil)
    arr.detect{|item| element_exists?(item, number, text) }
  end

  def element_value(element, number, text = nil)
    ele = text.nil? ? element(element, number) : element(element, number, text)
    ele.text
  end

  def element_exists?(parent, number, text = nil)
    res = text.nil? ? element(parent, number) : element(parent, number, text)
    res.size > 0
  end

  def sub_element_exists?(parent, number, text = nil)
    res = text.nil? ? sub_element(parent, number) : sub_element(parent, number, text)
    res.size > 0
  end

  def element(parent, number, text = nil)
    text.nil? ? parent.css("element[Id='#{number}']") : parent.css("element[Id='#{number}']:contains('#{text}')")
  end

  def sub_element(parent, number, text = nil)
    text.nil? ? parent.css("subelement[Sequence='#{number}']") : parent.css("subelement[Sequence='#{number}']:contains('#{text}')")
  end

  def sub_element_value(parent, number, text = nil)
    ele = sub_element(parent, number, text)
    ele.text
  end

  def dtp_value(dtp)
    element_value(dtp, 'DTP03')
  end

  def get_dates_from_range(date)
    date.split("-")
  end

  def formatted_amount(amount)
    number_to_currency(amount, :format => "%n", :delimiter => "")
  end

  def formatted_date(date)
    Date.strptime(date, "%Y%m%d") if date.present?
  end
end
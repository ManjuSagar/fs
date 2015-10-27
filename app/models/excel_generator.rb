class ExcelGenerator
  attr_reader :workbook_class, :font_class, :hssf_row, :hssf_cell, :hssf_sheet, :output_file_class, :input_file_class
  attr_reader :cell_range_address, :reference_obj, :static_fields, :input_file, :output_file, :work_book, :sheet

  def initialize(reference_obj, static_fields)
    Rjb::load(ENV['CLASS_PATH'], [ENV['JVM_ARGS']]) unless Rjb::loaded?
    @output_file_class = Rjb::import('java.io.FileOutputStream')
    @input_file_class = Rjb::import('java.io.FileInputStream')
    @workbook_class = Rjb::import('org.apache.poi.hssf.usermodel.HSSFWorkbook')
    @font_class = Rjb::import('org.apache.poi.hssf.usermodel.HSSFFont')
    @hssf_row = Rjb::import('org.apache.poi.hssf.usermodel.HSSFRow')
    @hssf_cell = Rjb::import('org.apache.poi.hssf.usermodel.HSSFCell')
    @hssf_sheet = Rjb::import('org.apache.poi.hssf.usermodel.HSSFSheet')
    @cell_range_address  = Rjb::import('org.apache.poi.ss.util.CellRangeAddress')
    @reference_obj = reference_obj
    @static_fields = static_fields

    @input_file = @input_file_class.new("#{Rails.root}/templates/final_claim_template.xls")
    file_name = "#{Rails.root}/tmp/#{reference_obj.treatment.patient.last_name}".downcase + "_#{reference_obj.treatment.patient.patient_reference}.xls"
    @output_file = @output_file_class.new(file_name)
    @output_file_path = file_name
    @work_book = @workbook_class.new(input_file)
    @sheet = @work_book.getSheet('Sheet1')
  end

  def cell_style
    courier_font = work_book.createFont
    courier_font.setFontName('Courier New')
    default_style = work_book.createCellStyle
    default_style.setFont( courier_font)
    default_style
  end

  def generate_excel
    #sheet.setDefaultRowHeight(5)
    set_field_values
    receivables = reference_obj.receivables
    set_receivables(receivables)
    input_file.close()
    work_book.write(output_file)
    output_file.close
    @output_file_path
  end

  def excel_column_index(column_char)
    arr = ('A'..'ZZ').to_a
    arr.index(column_char)
  end

  def set_field_values
    static_fields.each{|cell_ref, method|
      cell_ref.to_s.match(/([a-zA-Z]+)(\d+)/)
      row = sheet.getRow($2.to_i - 1)
      cell = row.getCell(excel_column_index($1))
      cell.setCellValue(reference_obj.send(method).to_s)
    }
  end

  def  set_receivables(receivables)
    cell_ref = 'B46'
    init_row = 43
    receivables.each_with_index{|receivable, index|
      num = (index % 21) + 1
      values = [num, receivable.revenue_code, receivable.purpose, receivable.hcpcs_code, receivable.service_date_format, receivable.service_units, receivable.receivable_amount, num]
      cell_ref.to_s.match(/([a-zA-Z]+)(\d+)/)
      row = sheet.getRow($2.to_i - 1)
      columns = [$1, 'D', 'J', "AO", "BH", "BQ", "BZ", "CY"]
      row_index = $2.to_i - 1
      row = check_format_or_create_row(init_row, row, index, columns)
      columns.each_with_index do |column_char, index|
        create_and_set_cell(row, column_char, values[index].to_s)
      end
      cell_ref = cell_ref[0] + "#{cell_ref[1..-1].to_i + 2}"
    }
  end

  def create_and_set_cell(row, column_char, value)
    cell = row.createCell(excel_column_index(column_char))
    cell.setCellValue(value)
    cell.setCellStyle(cell_style)
  end

  def check_format_or_create_row(init_row, row, index, columns)
    test_cell = row.getCell(excel_column_index(columns.first))
    unless test_cell
      row1_index = init_row + (index * 2)
      row2_index = init_row + (index * 2) + 1
      sheet.shiftRows(row2_index + 2, row2_index + 2 + 57, 2, true, false, true)

      row = sheet.createRow(row1_index)
      row2 = sheet.createRow(row2_index)

      add_merge_region(row1_index, row2_index, excel_column_index('D'), excel_column_index('H'))
      add_merge_region(row1_index, row2_index, excel_column_index('J'), excel_column_index('AM'))
      add_merge_region(row1_index, row2_index, excel_column_index('AO'), excel_column_index('BE'))
      add_merge_region(row1_index, row2_index, excel_column_index('BH'), excel_column_index('BO'))
      add_merge_region(row1_index, row2_index, excel_column_index('BQ'), excel_column_index('BX'))
      add_merge_region(row1_index, row2_index, excel_column_index('BZ'), excel_column_index('CK'))
    end
    row
  end

  def add_merge_region(first_row, last_row, first_col, last_col)
    cel_range = cell_range_address.new(first_row, last_row, first_col, last_col)
    sheet.addMergedRegion(cel_range)
  end
end
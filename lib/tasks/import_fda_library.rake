desc "Import FDA Library, EX: rake import_fda_library"
task :import_fda_library  => [:environment] do
  msg = "FDA Library Successfully imported on #{Date.current.strftime('%m/%d/%Y')}"
  begin
    `curl http://www.fda.gov/downloads/Drugs/InformationOnDrugs/UCM054599.zip > fda_library.zip`
    `unzip -o fda_library.zip -d fda_library`
    `ruby -pe "gsub(34.chr,'')" < fda_library/Product.txt > fda_library/product.csv`
    `ruby -pe "gsub(34.chr,'')" < fda_library/application.txt > fda_library/application.csv`

    create_drug_companies

    create_dosage_form_and_library

    `rm -rf fda_library`
  rescue Exception => e
    msg = "While importing FDA Library something went wrong. Details are\n #{e.message}, #{e.backtrace}"
  end

  FasternotesMailer.send_fda_library_import_notification(msg).deliver
end

require 'csv'
def create_drug_companies
  application_arr = CSV.read("fda_library/application.csv")

  application_arr.each_with_index{|r, i|
    next if i == 0 or r[0].nil?
    a = r[0].split("\t")
    comp = DrugCompany.find_by_name(a[2])
    if comp
      comp.update_attributes(app_nos_string: comp.app_nos_string + ", #{a[0]}") unless comp.app_nos_string.include?(a[0])
    else
      DrugCompany.create!(name: a[2], app_nos_string: "#{a[0]}")
    end
  }
end

def create_dosage_form_and_library
  product_arr = CSV.read("fda_library/product.csv", {:col_sep => "\t"})
  m_status_map = {"1" => "Prescription", "2" => "Over - the - counter", "3" => "Discontinued", "4" => "None (Tentative Approval)"}
  batch_arr = []
  no_of_records = product_arr.size
  product_arr.each_with_index{|a, i|
    next if i == 0 or a.nil?
    form = DosageForm.find_by_form(a[2])
    form = DosageForm.create!(:form => a[2]) unless form

    drug = FdaDrugLibrary.where(:drug_name => a[7], :strength => a[3], :active_ingredients => a[8], :form_id => form.id)
    if drug.first.nil?
      batch = {strength: a[3], active_ingredients: a[8], drug_name: a[7]}
      batch[:marketing_status] = m_status_map[a[4]]
      batch[:form] = form
      companies = DrugCompany.where(["app_nos_string LIKE ?", "%#{a[0]}%"])
      batch[:company] = companies.first
      batch_arr << batch
    end

    if((i%500 == 0) or (no_of_records == (i + 1))) and (not batch_arr.empty?)
      FdaDrugLibrary.create!(batch_arr)
      batch_arr = []
    end

  }

end
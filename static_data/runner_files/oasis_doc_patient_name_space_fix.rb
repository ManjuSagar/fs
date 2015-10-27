class Document1 < ActiveRecord::Base
  set_table_name "documents"
  include OasisExtension
  def valid_document?
    true
  end

  def hipps_code_required_doc?
    false
  end
end
doc_ids = [1389, 2096, 3029, 3298, 3335, 3611, 947, 1104, 1105, 1106, 1226, 1232, 1350, 1475, 1602, 1606, 1607,
           1735, 1859, 2017, 2568, 2708, 2709, 2849, 2884, 2888, 3006, 3097, 3115, 1470, 1611, 1625, 1717, 2592, 2599, 3295]

doc_ids.each do |doc_id|
  doc = Document1.find(doc_id)
  first_name = doc.m0040_pat_fname
  last_name = doc.m0040_pat_lname
  if (first_name != first_name.strip or last_name != last_name.strip)
    doc.m0040_pat_fname = first_name.strip
    doc.m0040_pat_lname = last_name.strip
    doc.save
  end
end
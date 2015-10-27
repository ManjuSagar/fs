class Document < ActiveRecord::Base
  include OasisExtension
  def valid_document?
    true
  end

  def hipps_code_required_doc?
    false
  end
end

class UpdateOasisFieldSpecs < ActiveRecord::Migration
  def change
    old_field_names = ["m1332_num_stas_ulcr", "m1800_cur_grooming", "m1810_cur_dress_upper", "m1820_cur_dress_lower", "m1840_cur_toiltg", "m1845_cur_toiltg_hygn", "m1850_cur_trnsfrng", "m1870_cur_feeding", "m1880_cur_prep_lt_meals", "m1890_cur_phone_use", "m2200_ther_need_num"]
    new_field_names = [ "m1332_nbr_stas_ulcr", "m1800_crnt_grooming", "m1810_crnt_dress_upper", "m1820_crnt_dress_lower", "m1840_crnt_toiltg", "m1845_crnt_toiltg_hygn", "m1850_crnt_trnsfrng", "m1870_crnt_feeding", "m1880_crnt_prep_lt_meals", "m1890_crnt_phone_use", "m2200_ther_need_nbr"]

    old_field_names.each_with_index do |old_field, index|
      field_spec = OasisFieldSpec.find_by_field_name(old_field.upcase)
      field_spec.update_attribute(:field_name, new_field_names[index].upcase) if field_spec
    end
    documents = Document.all
    documents.each do |doc|
      old_field_names.each_with_index do |old_field, index|
        value = doc.data[old_field]
        doc.data.delete(old_field)
        doc.send("#{new_field_names[index]}=", value)
      end
      doc.save(:validation => false)
    end
  end
end

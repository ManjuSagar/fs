class DeleteDuplicatedAttachmentType < ActiveRecord::Migration
  def change
    codes = ["ROUTE_SHEET", "MAP", "SIGNATURE", "REFERRAL", "MEDICAL_ORDER", "DOCUMENT", "OTHERS"]
  codes.each{|code|
    attachment_types = AttachmentType.where(["attachment_code = ?", code]).order("id")
    if attachment_types.size > 1
      attachment_types.each_with_index{|at, i| at.destroy if i != 0}
    end
  }
  end
end

class MakeExistingOrgStaffAsAdmin < ActiveRecord::Migration
  def change
    org_users = OrgUser.unscoped.includes(:user).where({:users => {:user_type => "OrgStaff"}})
    org_users.each{|ou| ou.update_attribute("role_type","A")}
  end
end

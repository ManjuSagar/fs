class User < ActiveRecord::Base;end
class OrgStaff < User;end
class FieldStaff < User;end
class LiteFieldStaff < FieldStaff;end
class Physician < User;end
class Org < ActiveRecord::Base;end
class StaffingCompany < Org;end

[OrgStaff, FieldStaff, LiteFieldStaff, Physician].each do |klass|
  klass.all.each{|s|
    s.email = "fnpublic+#{s.last_name.downcase}@gmail.com"
    l = true
    count = 1
    while l
      user = User.find_by_email s.email
      if user.present?
        s.email = "fnpublic+#{s.last_name.downcase}#{count}@gmail.com"
      else
        l = false
      end
      count += 1
    end
    s.encrypted_sign_password = BCrypt::Password.create("test1234")
    s.encrypted_password = BCrypt::Password.create("test1234")
    s.save
  }

end

[StaffingCompany].each do |klass|
  klass.all.each do |sc|
    next unless sc.org_name
    sc.email = "fnpublic+#{sc.org_name[0..4].downcase.split(' ').join("_")}@gmail.com"
    sc.save
  end
end
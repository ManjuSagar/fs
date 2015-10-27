# == Schema Information
#
# Table name: org_field_staff_visit_types
#
#  id            :integer          not null, primary key
#  org_user_id   :integer          not null
#  visit_type_id :integer          not null
#  payable_rate  :decimal(8, 2)
#

class OrgFieldStaffVisitType < ActiveRecord::Base
  belongs_to :visit_type
  belongs_to :org_user
  after_save :change_payables_rate, :unless => :new_record?

  audited :associated_with => :org_user, :allow_mass_assignment => true

  scope :fs_scope, lambda{|user_id, org| includes(:org_user).where(:org_users => {:user_id => user_id, :org_id => org})}

  attr_accessor :approved

  netzke_attribute :approved, :type => :boolean

  def calculate_payable_amount(time_in_hour)
    rate = self.hourly_rate
    rate ? time_in_hour * rate : 0
  end

  private

  def change_payables_rate
    payables = Payable.org_scope.where({source_type: "TreatmentVisit", payroll_id: nil, payee_type: "User", payee_id: org_user.user.id})
    payables.each{|p|
       rate, amount = if  p.treatment.hourly_rate_for_fs?
                        time_in_hr = p.source.time_taken_for_visit_in_hours
                        [hourly_rate, calculate_payable_amount(time_in_hr)]
                      else
                        [visit_rate, visit_rate]
                      end
       if p.source.present? && p.source.visit_type == visit_type
         p.payable_amount = amount
         p.rate = rate
         p.save!
       end
    }
  end

end

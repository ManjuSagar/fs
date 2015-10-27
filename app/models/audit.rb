class Audit < ActiveRecord::Base

  belongs_to :user
  belongs_to :auditable, :polymorphic => true
  belongs_to :associated, :polymorphic => true

  default_scope lambda {order("audits.id DESC")}

  scope :org_scope, lambda{ where(org_id: Org.current.id) }

  def self.get_data(audit_id)
    audit = find(audit_id)
    changes = YAML.load(audit.audited_changes)
    data = []
    not_interested_attrs = settings[audit.auditable_type]["not_interested_attrs"] if settings[audit.auditable_type]
    if audit.action == "destroy"
      data += changes.collect{|k, v| (v.is_a? Array)? [audit.id, k.titleize, v[0], v[1]] : [audit.id, k.titleize, nil, v]}
    else
      changes.each{|k, v|
        next if v.nil?
        next if not_interested_attrs.include?(k) if not_interested_attrs
        value = audit.modified_value(k, v)
        field = audit.field_name(k)
        data << if v.is_a? Array
                  [audit.id, field, v[0], v[1]]
                else
                  [audit.id, field, nil, value]
                end
      }
    end
    data
  end

  def field_name(attr)
    return attr.titleize if Audit.settings[auditable_type].nil?
    change_attr_names = Audit.settings[auditable_type]["change_attr_names"]
    change_attr_names.has_key?(attr)? change_attr_names[attr] : attr.titleize
  end

  def modified_value(attr, v)
    return v if Audit.settings[auditable_type].nil?
    value = (v.is_a? Array)? v : [v]

    association_attrs = Audit.settings[auditable_type]["association_attrs"]
    polymorphic_fields = Audit.settings[auditable_type]["polymorphic_fields"]

    value.each_with_index do |val, index|
      next if val.nil?
      if attr.end_with?("_id")
        assoc = attr[0..-4]
        polymorphic_fields_present = polymorphic_fields.has_key?(assoc)
        if (association_attrs.has_key?(assoc) or polymorphic_fields_present)
          if polymorphic_fields_present
            value[index] = self.auditable.send(assoc).to_s
          else
            value[index] = association_attrs[assoc].constantize.find(val).to_s
          end
        end
      elsif attr.end_with?("status")
        value[index] = self.auditable.send(attr).to_s.titleize
      else
        value[index] = val
      end
      value[index] = formatted_attr_value(attr, value[index])
    end
    value
  end

  def formatted_attr_value(attr, value)
    attr_type = self.auditable.class.columns_hash[attr].type
    if attr_type == :date
      Date.parse(value.to_s).strftime("%m/%d/%Y")
    elsif attr_type == :datetime
      Time.parse(value.to_s).strftime("%m/%d/%Y %H:%M")
    else
      value
    end
  end

  def self.settings
    {
        "TreatmentPhysician" => {"not_interested_attrs" => [],
                                 "association_attrs" => {"treatment" => "PatientTreatment", "physician" => "Physician"},
                                 "polymorphic_fields" => {},
                                 "change_attr_names" => {"primary_referral_flag" => "Primary Physician", "require_cc_flag" => "Require CC"}},

        "Payroll" => {"not_interested_attrs" => ["org_id", "payee_type"],
                     "association_attrs" => {"office_staff" => "OrgStaff"},
                     "polymorphic_fields" => {"payee" => ["Org", "User"]},
                     "change_attr_names" => {"payroll_date" => "Date", "payroll_amount" => "Amount", "payroll_reference" => "Reference"}},

        "Receivable" => {"not_interested_attrs" => ["org_id", "payer_type", "invoice_payment_id", "source_type", "source_id", "receivable_type"],
                         "association_attrs" => {"invoice" => "Invoice", "treatment" => "PatientTreatment", "treatment_episode" => "TreatmentEpisode"},
                         "polymorphic_fields" => {"payer" => ["InsuranceCompany", "User"]},
                         "change_attr_names" => {"receivable_status" => "Status", "receivable_date" => "Date", "receivable_amount" => "Amount"}},

        "TreatmentVisit" => {"not_interested_attrs" => ["fs_sign_required", "os_sign_required", "invoice_payment_id", "source_type", "source_id", "receivable_type"],
                             "association_attrs" => {"agency_approved_user" => "OrgStaff", "treatment" => "PatientTreatment", "treatment_episode" => "TreatmentEpisode"},
                             "polymorphic_fields" => {"payer" => ["InsuranceCompany", "User"]},
                             "change_attr_names" => {"agency_approved_user_id" => "Agency Staff", "fs_sign_date" => "FS Sign Date", "os_sign_date" => "OS Sign Date"}},

        "VisitAttachment" => {"not_interested_attrs" => ["attachment_content_type", "attachment_file_size", "attachment_name"],
                             "association_attrs" => {"visit" => "TreatmentVisit", "attachment_type" => "AttachmentType"},
                             "polymorphic_fields" => {},
                             "change_attr_names" => {"attachment_file_name" => "File Name", "attachment_updated_at" => "Updated At"}},

        "TreatmentRequestStaff" => {"not_interested_attrs" => ["staff_type"],
                                   "association_attrs" => {"request" => "TreatmentRequest", "discipline" => "Discipline"},
                                   "polymorphic_fields" => {"staff" => ["User", "Org"]},
                                   "change_attr_names" => {}},
    }
  end

end
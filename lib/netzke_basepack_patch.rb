require 'netzke/basepack/data_adapters/active_record_adapter'
module Netzke::Basepack::DataAdapters
  class ActiveRecordAdapter < AbstractAdapter
    def get_assoc_property_type assoc_name, prop_name
      if prop_name && assoc=@model_class.reflect_on_association(assoc_name)
        return :netzkeremotecombo if assoc.options and assoc.options.keys.include? :polymorphic
        assoc_column = assoc.klass.columns_hash[prop_name.to_s]
        assoc_column.try(:type)
      end
    end

    def apply_column_filters(relation, column_filter)
      res = relation
      operator_map = {"lt" => "<", "gt" => ">", "eq" => "="}
      # these are still JSON-encoded due to the migration to Ext.direct
      column_filter=JSON.parse(column_filter)
      column_filter.each do |v|
        value = v["value"]
        field = v['field']
        like_value = "%#{value.upcase}%" if value.is_a? String
        if v["type"] == "date"
          col = @model_class.columns.detect{|c| c.name == field}
          if col and col.type == :datetime
            value = Date.strptime(value, "%m/%d/%Y").to_time.utc.strftime("%Y-%m-%d")
          else
            value.match /(\d\d)\/(\d\d)\/(\d\d\d\d)/
            value = "#{$3}-#{$1}-#{$2}"
          end
        end

        filter_map = {"right" => 't', "wrong" => 'f', "play" => "n"}
        authorization_status_map = {"right" => true, "wrong" => 'null'}

        case field
          when 'invoice_status'
            status = (value == 'A' ? ["A", "N"] : [value])
            res = res.where(['invoice_status in (?)', status])
            next
          when 'claim_number'
            res = res.where(["invoice_id in (select id from invoices where invoice_number = ?)", value.to_i])
            next
          when 'org_name'
            res = res.joins(:invoice).where(["invoices.org_id IN (SELECT id FROM orgs WHERE upper(org_name) LIKE ?)", like_value])
            next
          when 'correction_num_display'
            res = res.where(["oasis_exports.correction_num = ?", value.to_i])
            next
          when 'insurance_company'
            res = res.joins(:insurance_company).where(["insurance_company_id IN (SELECT id FROM insurance_companies WHERE upper(company_name) LIKE ?)", like_value])
            next
          when 'full_name'
            res = res.where(["upper(first_name) LIKE ? OR upper(last_name) LIKE ?", like_value, like_value ])
            next
          when 'treatment_start_date'
            res = res.where(["users.id IN (SELECT patient_id FROM patient_treatments WHERE treatment_start_date = ?)", value ])
            next
          when 'field_staff_name'
            res = res.where(["field_staff_id IN (SELECT id FROM users WHERE upper(users.first_name) LIKE ? OR upper(users.last_name) LIKE ?)", like_value, like_value])
            next
          when 'field_staff'
            user_ids = "select u.id from users u where upper(u.first_name) LIKE ? OR upper(u.last_name) LIKE ?"
            res = res.where(["receivables.id in (select r.id from receivables r inner join treatment_visits tv on r.source_id = tv.id
                  where r.source_type = 'TreatmentVisit' and tv.visited_user_id in (#{user_ids}))" , like_value, like_value])
            next
          when 'units_display'
            res = res.where(["source_type='TreatmentVisit' and treatment_id in
                            (select tr.id from patient_treatments tr inner join treatment_requests tq on tr.treatment_request_id = tq.id
                      where tq.field_staff_bill_type = ?)", value])
            next
          when 'treatment__to_s'
            res = res.where(["#{@arel.name}.treatment_id IN (SELECT pt.id FROM patient_treatments pt INNER JOIN users ON pt.patient_id = users.id
                            WHERE upper(users.first_name) LIKE ? OR upper(users.last_name) LIKE ?)", like_value, like_value ])
            next
          when 'created_user__full_name'
            res = res.where(["created_user_id IN (SELECT id FROM users WHERE upper(users.first_name) LIKE ? OR upper(users.last_name) LIKE ?)", like_value, like_value])
            next
          when 'staff_sign_date'
            res = res.where(["date(printable_order_updated_at) = ?", value])
            next
          when 'physician__full_name'
            res = res.where(["physician_id IN (SELECT id FROM users WHERE upper(users.first_name) LIKE ? OR upper(users.last_name) LIKE ?)", like_value, like_value])
            next
          when 'physician__first_name'
            res = res.where(["physician_id IN (SELECT id FROM users WHERE upper(users.first_name) LIKE ?)", like_value])
            next
          when 'physician__last_name'
            res = res.where(["physician_id IN (SELECT id FROM users WHERE upper(users.last_name) LIKE ?)", like_value])
            next
          when 'physician__npi_number'
            res = res.where(["physician_id IN (SELECT id FROM users WHERE upper(users.npi_number) LIKE ?)", like_value])
            next
          when 'order_type__type_description'
            res = res.where(["order_type_id = ?", value])
            next
          when 'oasis_document__treatment__to_s'
            res = res.where(["document_id IN (SELECT id FROM documents WHERE treatment_id IN (SELECT pt.id FROM patient_treatments pt
                              INNER JOIN users ON pt.patient_id = users.id WHERE upper(users.first_name) LIKE ? OR upper(users.last_name) LIKE ?))", like_value, like_value])
            next
          when 'oasis_document_date_display'
            res = res.where(["document_id IN (SELECT id FROM documents WHERE document_date = ?)", value])
            next
          when 'oasis_document__document_definition__document_name'
            res = res.where(["document_id IN (SELECT d.id FROM documents d INNER JOIN document_definitions dd ON d.document_definition_id = dd.id
                              WHERE upper(dd.document_name) LIKE ?)", like_value])
          when 'exported_date_time'
            res = res.where(["date(exported_date_time) = ?", value])
            next
          when 'user__first_name'
            res = res.where(["user_id IN (SELECT id FROM users WHERE upper(first_name) LIKE ?)", like_value])
            next
          when 'user__last_name'
            res = res.where(["user_id IN (SELECT id FROM users WHERE upper(last_name) LIKE ?)", like_value])
            next
          when 'user__full_name'
            res = res.where(["user_id in (SELECT id FROM users WHERE upper(first_name) LIKE ? OR upper(last_name) LIKE ?)", like_value, like_value])
            next
          when 'user__email'
            res = res.where(["user_id IN (SELECT id FROM users WHERE upper(email) LIKE ?)", like_value])
            next
          when 'user__license_type_code'
            res = res.where(["user_id IN (SELECT field_staff_id FROM field_staff_details WHERE license_type_id = ?)", value])
            next
          when 'npi_number'
            res = res.where(["id IN (SELECT physician_id FROM physician_details WHERE upper(npi_number) LIKE ?)", like_value])
            next
          when 'payee_field_staff_name'
            user_ids = "select u.id from users u where upper(u.first_name) LIKE ? OR upper(users.last_name) LIKE ?"
            res = res.where(["payrolls.id in (select p.id from payrolls p inner join payables pp on p.id = pp.payroll_id
                  where pp.field_staff_id in (#{user_ids}))" , like_value, like_value])
            next
          when 'office_staff__full_name'
            res = res.where(["office_staff_id IN (SELECT id FROM users WHERE upper(users.first_name) LIKE ? OR upper(users.last_name) LIKE ?)", like_value, like_value])
            next
          when 'staff_type'
            res = res.where(["payee_type = ?", value])
            next
          when 'current_status'
            res = res.where(["source_type = ? AND source_id IN (SELECT v.id FROM treatment_visits v WHERE v.visit_status IN (?))", "TreatmentVisit", value])
            next
          when 'visit_status_display'            
            res = res.where(["source_type = ? AND source_id IN (SELECT v.id FROM treatment_visits v WHERE v.visit_status IN (?))", "TreatmentVisit", value])
            next
          when 'payer_name'
            res = res.where(["((payer_type = ? AND payer_id IN (SELECT i.id FROM insurance_companies i WHERE upper(i.company_code) LIKE ?)) OR
                    (payer_type = ? AND payer_id IN (SELECT u.id FROM users u WHERE upper(u.first_name) LIKE ? OR upper(u.last_name) LIKE ?)))",
                             "InsuranceCompany", like_value, "User", like_value, like_value])
            next
          when 'health_agency'
            res = res.where(["org_id IN (SELECT id FROM orgs WHERE upper(org_name) LIKE ?)", like_value])
            next
          when 'patient_mr_no'
            res = res.where(["treatment_id IN (SELECT pt.id FROM patient_treatments pt INNER JOIN users u ON u.id = pt.patient_id
                             INNER JOIN patient_details pd ON u.id = pd.patient_id AND pd.patient_reference LIKE ?)", like_value])
            next
          when 'patient_hi_claim_number'
            res = res.where(["invoices.treatment_id IN (SELECT pt.id FROM patient_treatments pt INNER JOIN users u ON u.id = pt.patient_id
                             INNER JOIN patient_details pd ON u.id = pd.patient_id AND pd.medicare_number LIKE ?)", like_value])
            next
          when 'patient_name'
            res = res.where(["treatment_id IN (SELECT pt.id FROM patient_treatments pt INNER JOIN users u ON u.id = pt.patient_id
                            WHERE upper(u.first_name) LIKE ? OR upper(u.last_name) LIKE ?)", like_value, like_value])
            next
          when 'e_certification_period'
            res = res.where(["e_start_date <= ? AND e_end_date >= ?", value, value])
            next
          when 'soc_date'
            res = res.where(["treatment_id IN (SELECT pt.id FROM patient_treatments pt WHERE pt.treatment_start_date = ?)", value])
            next
          when 'treatment_status'
            res = res.where(["treatment_id IN (SELECT pt.id FROM patient_treatments pt WHERE pt.treatment_status = ?)", value])
            next
          when 'document_date_display'
            res = res.where(["document_date = ?", value])
            next
          when 'e_disciplines_display'
            res = res.where(["patient_treatment_id IN (SELECT treatment_id FROM treatment_disciplines td WHERE discipline_id = ?)", value])
            next
          when 'treatment_episode__to_s'
            res = res.where(["treatment_episode_id IN (SELECT te.id FROM treatment_episodes te WHERE te.start_date <= ? AND te.end_date >= ?)", value, value])
            next
          when 'agency_name'
            res = res.where(["org_id IN (SELECT id FROM orgs WHERE upper(org_name) LIKE ?)", like_value])
            next
          when 'e_eligibility_check_flag'
            value = filter_map["#{value}"]
            res = res.where("(patient_treatment_record_type= 1 and  e_eligibility_check_flag = '#{value}') or (patient_record_type= 2 and  p_eligibility_flag = '#{value}')
                     or (treatment_request_record_type= 3 and  treatment_request_eligibility_flag = '#{value}')")
            next
          when 'e_staffing_flag'
            value = filter_map["#{value}"]
            res = res.where("(patient_treatment_record_type= 1 and  e_staffing_flag = '#{value}') or (patient_record_type= 2 and  p_staffing_flag = '#{value}')
                     or (treatment_request_record_type= 3 and  treatment_request_staffing_flag = '#{value}')")
            next
          when 'e_referral_received_flag'
            value = filter_map["#{value}"]
            res = res.where("(patient_treatment_record_type= 1 and  e_referral_received_flag = '#{value}') or (patient_record_type= 2 and  p_referral_flag = '#{value}')
                     or (treatment_request_record_type= 3 and  treatment_request_ref_received_flag = '#{value}')")
            next
          when 'e_plan_of_care_completed_flag'
            value = filter_map["#{value}"]
            res = res.where("(patient_treatment_record_type= 1 and  e_plan_of_care_completed_flag = '#{value}') or (patient_record_type= 2 and  p_poc_flag = '#{value}')
                     or (treatment_request_record_type= 3 and  treatment_request_poc_flag = '#{value}')")
            next
          when 'e_rap_status'
            value = filter_map["#{value}"]
            res = res.where("(patient_treatment_record_type= 1 and  e_rap_status = '#{value}') or (patient_record_type= 2 and  p_rap_flag = '#{value}')
                     or (treatment_request_record_type= 3 and  treatment_request_rap_flag = '#{value}')")
            next
          when 'e_documents_status'
            value = filter_map["#{value}"]
            res = res.where("(patient_treatment_record_type= 1 and  e_documents_status = '#{value}') or (patient_record_type= 2 and  p_doc_flag = '#{value}')
                     or (treatment_request_record_type= 3 and  treatment_request_doc_flag = '#{value}')")
            next
          when 'e_medical_orders_status'
            value = filter_map["#{value}"]
            res = res.where("(patient_treatment_record_type= 1 and  e_medical_orders_status = '#{value}') or (patient_record_type= 2 and  p_mo_flag = '#{value}')
                     or (treatment_request_record_type= 3 and  treatment_request_mo_flag = '#{value}')")
            next
          when 'e_discharged_flag'
            value = filter_map["#{value}"]
            res = res.where("(patient_treatment_record_type= 1 and  e_discharged_flag = '#{value}') or (patient_record_type= 2 and  p_dc_flag = '#{value}')
                     or (treatment_request_record_type= 3 and  treatment_request_dc_flag = '#{value}')")
            next
          when 'e_final_claim_sent_flag'
            value = filter_map["#{value}"]
            res = res.where("(patient_treatment_record_type= 1 and  e_final_claim_sent_flag = '#{value}') or (patient_record_type= 2 and  p_fc_flag = '#{value}')
                     or (treatment_request_record_type= 3 and  treatment_request_fc_flag = '#{value}')")
            next
          when 'e_oasis_document_completed_flag'
            value = filter_map["#{value}"]
            res = res.where("(patient_treatment_record_type= 1 and  e_oasis_document_completed_flag = '#{value}') or (patient_record_type= 2 and  p_oasis_flag = '#{value}')
                     or (treatment_request_record_type= 3 and  treatment_request_oasis_flag = '#{value}')")
            next
          when 'sent_date_display'
            res = res.where(["invoice_id in (select id from invoices where sent_date = ?)", value])
            next
          when 'invoice_no'
            res = res.where(["invoice_package_id in (select id from invoice_packages where package_number = ? and org_id = ?)", value, Org.current.id])
            next
          when 'due_date_display'
            res = res.where(["due_date = ?", value])
            next
          when 'payment_due_date_display'
            res = res.where(["payment_due_date = ?", value])
            next
          when 'patient_full_name'
            res = res.where(["authorization_trackings.patient_id IN (SELECT id FROM users WHERE upper(first_name)  LIKE ? OR upper(last_name) LIKE ?)", like_value, like_value])
            next
          when 'insurance_company_code'
            res = res.where(["insurance_company_id IN (SELECT id FROM insurance_companies WHERE upper(company_code) LIKE ?)", like_value])
            next
          when 'insurance_case_manager_name'
            res = res.where(["insurance_case_manager_id IN (SELECT id FROM insurance_case_managers WHERE upper(first_name) LIKE ? OR upper(last_name) LIKE ?)",like_value, like_value])
          next
          when 'discipline_display'
            res = res.where(["authorization_trackings.discipline_id IN (SELECT id FROM disciplines WHERE id = ?)", value])
          next
          when 'discipline__discipline_code'
            res = res.where(["authorization_trackings.discipline_id IN (SELECT id FROM disciplines WHERE id = ?)", value])
          next
          when 'field_staff_display'
            ids = ActiveRecord::Base.connection.exec_query("SELECT id FROM users WHERE upper(first_name)  LIKE '#{like_value}' OR upper(last_name) LIKE '#{like_value}'").to_hash.collect{|x| x['id'].to_i}
            ids = ("Pending Staffing".upcase.include? value.upcase) ? ids + [0] : ids
            res = res.where(["field_staff_id IN (?)", ids])
          next
          when 'field_staff__full_name'
            ids = ActiveRecord::Base.connection.exec_query("SELECT id FROM users WHERE upper(first_name)  LIKE '#{like_value}' OR upper(last_name) LIKE '#{like_value}'").to_hash.collect{|x| x['id'].to_i}
            ids = ("Pending Staffing".upcase.include? value.upcase) ? ids + [0] : ids
            res = res.where(["field_staff_id IN (?)", ids])
          next
          when 'reported'
            value = authorization_status_map["#{value}"]
            res = res.where("reported is #{value}")
          next
          when 'evaluation_sent'
            value = authorization_status_map["#{value}"]
            res = res.where("evaluation_sent is #{value}")
          next
          when 'approval_received'
            value = authorization_status_map["#{value}"]
            res = res.where("approval_received is #{value}")
          next
          when 'visit_done'
            value = authorization_status_map["#{value}"]
            res = res.where("visit_done is #{value}")
          next

        end

        next if ["eligibility_check_flag", "staffing_flag", "referral_received_flag", "oasis_document_completed_flag", "plan_of_care_completed_flag",
         "rap_status", "documents_status", "medical_orders_status", "discharged_flag", "final_claim_sent_flag"].include?(field)
=begin
        assoc, method = v["field"].split('__')
        if method
          assoc = @model_class.reflect_on_association(assoc.to_sym)
          field = [assoc.klass.table_name, method].join('.').to_sym
          if method == 'full_name'
            #field = "(#{assoc.klass.table_name.first_name })"
            res = res.where(["(users.first_name like ? OR users.last_name like ?)", "%#{v["value"]}%", "%#{v["value"]}%"])
            next
          end
        else
          if assoc == "field_staff_name"
            res = res.joins(:field_staff)
            res = res.where(["(users.first_name like ? OR users.last_name like ?)", "%#{v["value"]}%", "%#{v["value"]}%"])
            next
          end
          field = assoc.to_sym
        end
=end

        op = operator_map[v['comparison']]

        case v["type"]
          when "string"
            res = res.where(["upper(#{field}) like ?", like_value])
          when "date"
            # convert value to the DB date
            #value.match /(\d\d)\/(\d\d)\/(\d\d\d\d)/
            res = res.where("date(#{field}) #{op} ?", value)
          when "numeric"
            res = res.where(["#{field} #{op} ?", value])
          else
            res = res.where(["#{field} = ?", value])
        end
      end

      res
    end
  end
end

require 'netzke/active_record/relation_extensions'
module Netzke
  module ActiveRecord
    module RelationExtensions

      def extend_with(*params)
        scope = params.shift
        case scope.class.name
          when "Symbol" # model's scope
            self.send(scope, *params)
          when "String" # SQL query or SQL query with params (e.g. ["created_at < ?", 1.day.ago])
            params.empty? ? self.where(scope) : self.where([scope, *params])
          when "Array"
            # ORIGINAL: self.extend_with(*scope)
            # if condition added, since scope with parameters can't allowed in netzke scope.
            # 1. scope name is prefixed with 'scope_with_params,' it's a first element in array
            # 2. Remaining elements are parameters to scope
            if scope[0].start_with?("scope_with_params")
              self.send(scope[0].split(",").last, scope[1..(scope.size-1)])
            else
              self.extend_with(*scope)
            end
          when "Hash"  # conditions hash
            self.where(scope)
          when "ActiveSupport::HashWithIndifferentAccess" # conditions hash
            self.where(scope)
          when "Proc"   # receives a relation, must return a relation
            scope.call(self)
          else
            raise ArgumentError, "Wrong parameter type for ActiveRecord::Relation#extend_with"
        end
      end
    end
  end
end

require 'netzke/active_record/attributes'

module Netzke::ActiveRecord::Attributes
  # Fetches the value specified by an (association) attribute
  # If +through_association+ is true, get the value of the association by provided method, *not* the associated record's id
  # E.g., author__name with through_association set to true may return "Vladimir Nabokov", while with through_association set to false, it'll return author_id for the current record
  def value_for_attribute(a, through_association = false)
    v = if("fda_drug_library__drug_name" == a[:name])
          send("medication_name")
        elsif("fda_drug_library__dosage_form" == a[:name])
          send("dosage_form")
        elsif a[:getter]
          a[:getter].call(self)
        elsif respond_to?("#{a[:name]}")
          result = send("#{a[:name]}")
          # a work-around for to_json not taking the current timezone into account
          type = self.class.columns_hash[a[:name]].instance_variable_get(:@type)
          if (type == :date or type == :datetime) and result
            result = result.to_datetime if type == :date
            result = a[:grid_column] ? result.to_s(:db) : result.to_s[0..18] + " " + Time.zone.to_s[4..9]
            result
          else
            result
          end
        elsif is_association_attr?(a)
          split = a[:name].to_s.split(/\.|__/)
          assoc = self.class.reflect_on_association(split.first.to_sym)
          if through_association
            split.inject(self) do |r,m| # TODO: do we really need to descend deeper than 1 level?
              if r.respond_to?(m)
                r.send(m)
              else
                logger.debug "Netzke::Basepack: Wrong attribute name: #{a[:name]}" unless r.nil?
                nil
              end
            end
          elsif assoc.macro == :belongs_to and assoc.options.keys.include?(:polymorphic)
            obj = send(split.first.to_sym)
            obj ? "#{obj.class.name}_#{obj.id}" : obj
          else
            self.send("#{assoc.options[:foreign_key] || assoc.name.to_s.foreign_key}")
          end
        end

    # a work-around for to_json not taking the current timezone into account when serializing ActiveSupport::TimeWithZone
    v = v.to_datetime.to_s(:db) if [ActiveSupport::TimeWithZone].include?(v.class)
    v
  end

  # Assigns new value to an (association) attribute
  def set_value_for_attribute(a, v)
    v = v.to_time_in_current_zone if v.is_a?(Date) # convert Date to Time
    if v.present? and a[:xtype]
      if a[:xtype] and a[:xtype] == :datefield
        month, day, year = v.split('/')
        v = Date.new(year.to_i, month.to_i, day.to_i)
      elsif a[:xtype] and a[:xtype] == :xdatetime
        v = Time.strptime(v, "%m/%d/%Y %H:%M")
      elsif a[:xtype] and a[:xtype] == :datecolumn
        v = Date.strptime(v)
      end
    elsif a[:name].to_s.ends_with?( "document_date") and v.present?
      month, day, year = v.split('/')
      v = Date.new(year.to_i, month.to_i, day.to_i)
    end

    if("fda_drug_library__drug_name" == a[:name])
      if v.present?
        send("medication_name=", v)
        send("dosage=", v.include?('(') ? v.split("(").last.split(")").first : nil)
      end
    elsif("fda_drug_library__dosage_form" == a[:name])
      send("dosage_form=", v)
    elsif a[:setter]
      a[:setter].call(self, v)
    elsif respond_to?("#{a[:name]}=")
      if ((self.class.name == "TreatmentEpisode") and a[:name] == "discipline_ids")
        v.select{|x| x != false }.each{|id| treatment_disciplines.build(discipline_id: id, treatment_id: @treatment_id)}
      else
        send("#{a[:name]}=", v)
      end
    elsif is_association_attr?(a)
      split = a[:name].to_s.split(/\.|__/)
      if a[:nested_attribute]
        # We want:
        #     set_value_for_attribute({:name => :assoc_1__assoc_2__method, :nested_attribute => true}, 100)
        # =>
        #     self.assoc_1.assoc_2.method = 100
        split.inject(self) { |r,m| m == split.last ? (r && r.send("#{m}=", v) && r.save) : r.send(m) }
      else
        if split.size == 2
          # search for association and assign it to self
          assoc = self.class.reflect_on_association(split.first.to_sym)
          assoc_method = split.last
          if assoc
            if assoc.macro == :has_one
              assoc_instance = self.send(assoc.name)
              if assoc_instance
                assoc_instance.send("#{assoc_method}=", v)
                assoc_instance.save # what should we do when this fails?..
              else
                # what should we do in this case?
              end
            elsif assoc.macro == :belongs_to and assoc.options.keys.include?(:polymorphic)
              polymorphic_assoc_class_name, polymorphic_assoc_id = v.split("_") if v.present?
              obj = polymorphic_assoc_class_name.constantize.find(polymorphic_assoc_id) if polymorphic_assoc_class_name.present?
              self.send("#{split.first.to_sym}=", obj)
            else
              self.send("#{assoc.options[:foreign_key] || assoc.name.to_s.foreign_key}=", v)
            end
          else
          end
        else
        end
      end
    end
  end

end

require 'netzke/basepack/panel'
class Netzke::Basepack::Panel
    alias_method :original_initialize, :initialize
    def initialize(conf = {}, parent = nil)
      @form_panel = nil
      unless self.is_a?(Netzke::Basepack::FormPanel)
        current_panel = parent
        while (@form_panel.nil? and current_panel.nil? == false)
          if current_panel.is_a?(Netzke::Basepack::FormPanel)
            @form_panel = current_panel
          else
            current_panel = current_panel.instance_variable_get("@parent")
          end
        end
      end
      original_initialize conf, parent
      @form_panel.send(:normalize_fields, items) if @form_panel
    end
end

require 'netzke/basepack/window'
class Netzke::Basepack::Window
  plugin :unload_component_plugin
end

require "netzke/basepack/grid_panel"

require "netzke/basepack/grid_panel/record_form_window"

class Netzke::Basepack::GridPanel::RecordFormWindow

  js_properties :button_align => :right,
                :modal => true,
                :fbar => [{xtype: :combo,  width: "35%", item_id: :item_chooser, field_label: "Go to", label_width: '50px', store: [['---', '---']]},
                          {item_id: 'card-prev', tooltip: 'Previous', iconCls: 'icon-previous'},
                          {item_id: 'card-next', tooltip: 'Next', iconCls: 'icon-next'},'->',
                          {name: :sign_date, width: 230, field_label: "Signature Date", xtype: :datefield, item_id: :sign_date, format: 'm/d/Y', value: Date.current},
                          {name: :sign_password, width: 280, field_label: "Signature Password:<span style='color:red;'>*</span>",
                           label_separator: '', label_width: 150, xtype: :textfield, inputType: :password, item_id: :sign_password},
                           :new_field_staff.action,:medicare_eligibility.action, :previous_evaluation_report.action, :validate.action, :validate_all.action,
                          :save_and_new.action, :print.action, :edit.action, :approve.action, :save_draft.action, :ok.action, :cancel.action],
                :collapsible => true

  action :new_field_staff, text: "", tooltip: "New Field Staff", icon: :add_new
  action :previous_evaluation_report, text: "View Last Evaluation"
  action :validate, text: "Validate"
  action :validate_all, text: "Validate All", item_id: :validate_all
  action :medicare_eligibility, text: "Medicare Eligibility"
  action :print, text: '', icon: :print
  action :edit, text: '', icon: :edit
  action :approve, text: 'Approve'

  js_method :on_edit,<<-JS
    function(action){
      var form = this.items.first();
      onDocumentEdit(action, this.actions.approve, this.actions.ok, form);
    }
  JS

  js_method :on_approve,<<-JS
    function(){
      var form = this.items.first();
      onDocumentApprove(form);
    }
  JS

  js_method :on_print,<<-JS
    function(){
      var form = this.items.first();
      onPrint(form);
    }
  JS

  js_method :on_new_field_staff, <<-JS
    function(){
      var newFieldStaff = Ext.ComponentQuery.query("#new_field_staff")[0];
      newFieldStaff.onNewFieldStaff();
    }
  JS

  js_method :on_medicare_eligibility, <<-JS
  function(){
     var medicareEligibility = Ext.ComponentQuery.query('#medicare_eligibility')[0];
     medicareEligibility.onMedicareEligibility();
}
  JS

  js_method :on_validate, <<-JS
    function(){
      var superMain = Ext.ComponentQuery.query('#super_main')[0];
      superMain.onValidate();
    }
  JS

  js_method :on_validate_all, <<-JS
    function(){
      var superMain = Ext.ComponentQuery.query('#super_main')[0];
      superMain.onValidateAll();
    }
  JS



  js_method :on_previous_evaluation_report, <<-JS
    function(){
       var eval = Ext.ComponentQuery.query('#evaluation')[0];
       eval.onPreviousEvaluationReport();
    }
  JS

  js_method :after_render, <<-JS
    function(){
      this.callParent();
      if (this.items.first().showOasisDocumentActions){
        var comboList = Ext.ComponentQuery.query('#super_main')[0];
        var goTo = this.down('#item_chooser');
        goTo.store.add(comboList.extendedOasisPageList);
        goTo.store.remove(goTo.store.getAt(0));
        goTo.setValue(goTo.store.getAt(0));
        goTo.fireEvent('select', goTo);
      }
    }
  JS


  js_method :init_component, <<-JS
          function(params){
            this.callParent();
            if (this.items.first().enableSaveAndContinue == undefined) this.actions.saveAndNew.hide();
            if (this.items.first().showOasisDocumentActions == undefined) this.actions.validate.hide();
            if (this.items.first().showOasisDocumentActions == undefined) this.actions.validateAll.hide();
            if (this.items.first().showOasisDocumentActions == undefined) this.down('#item_chooser').hide();
            if (this.items.first().showOasisDocumentActions == undefined) this.down('#card-prev').hide();
            if (this.items.first().showOasisDocumentActions == undefined) this.down('#card-next').hide();
            if (this.items.first().showLastEvaluationAction == undefined) this.actions.previousEvaluationReport.hide();
            if (this.items.first().showMedicareEligibilityAction == undefined) this.actions.medicareEligibility.hide();
            if (this.items.first().showNewFieldStaffAction == undefined) this.actions.newFieldStaff.hide();
            if (this.items.first().signDateAndPasswordRequired != true) this.down("#sign_date").hide();
            if (this.items.first().signDateAndPasswordRequired != true) this.down("#sign_password").hide();
            if (this.items.first().showPrintIconOnEditForm != true) this.actions.print.hide();
            if (this.items.first().documentEditButtonRequired != true) this.actions.edit.hide();
            if (this.items.first().documentApproveButtonRequired != true) this.actions.approve.hide();
            if (this.items.first().saveDraftButtonRequired != true)
              this.actions.saveDraft.hide();
            //this.items.first().on("submitsuccess", function(){ this.closeRes = "ok"; this.close(); }, this);
          }
  JS
  js_method :on_save_and_new, <<-JS
    function(params){
      var currentForm = this.items.first(); //this.items.first().onApply();
      currentForm.notifyOnSave = false;
      currentForm.on("submitsuccess", function(){
        var episodeId = currentForm.treatmentEpisodeId;
        var treatmentId = currentForm.treatmentId;
        var medTreatmentCertValue = currentForm.getForm().getValues()["episode__certification_period"];
        var assessmentDate = currentForm.getForm().getValues()["assessment_date"];
        var startDate = currentForm.getForm().getValues()["start_date"];
        var visitId = currentForm.visitId;
        var model = currentForm.model;
        var parentModel = currentForm.parentModel;
        currentForm.clearStateOnDestroy = false;
        currentForm.unloadNetzkeComponentInServer({}, function(){
          if(model == "TreatmentVisit"){
            this.createNewRecordAndReturnId({current_model: model, treatment_id: treatmentId,
               treatment_episode_id: episodeId},function(result) {
              this.loadNetzkeComponent({name: "visit_edit_form", params: {record_id: result.id, component_params: {record_id: result.id}},container: this,
                callback: function(w){
                  w.show();
              }, scope: this});
            }, this);
          }else if(model == "TreatmentMedication"){
            this.loadNetzkeComponent({name: 'medication_form', params: {component_params: {treatment_id: treatmentId,
              epi_cert_period: medTreatmentCertValue, med_assessment_date: assessmentDate, med_start_date: startDate,
              visit_id: visitId, parent_model: parentModel}}, container: this,
              callback: function(w){
                w.show();
            }, scope: this});
          }
        }, this);
      }, this);
      currentForm.onApply();
    }
  JS

  js_method :destroy_current_form,<<-JS
    function(currentForm){
      currentForm.clearStateOnDestroy = false;
      currentForm.unloadNetzkeComponentInServer();
    }
  JS

  endpoint :create_new_record_and_return_id do |params|
    sample_record = params[:current_model].constantize.create_visit_instance(params[:treatment_id], params[:treatment_episode_id])
    {:set_result => {:id => sample_record.id}}
  end

  component :visit_edit_form do
    {
        class_name: "VisitEditForm",
        border: true,
        bbar: false,
        prevent_header: true,
    }
  end

  component :medication_form do
    {
        class_name: "TreatmentMedicationForm",
        border: true,
        bbar: false,
        prevent_header: true,
        record: medicare_record
    }
  end

  def medicare_record
    record = TreatmentMedication.new
    record.assessment_date = nil
    record.start_date = nil
    record
  end

  js_method :on_ok, <<-JS
      function(params){
        var currentForm = this.items.first();
        currentForm.on("submitsuccess", function(){ this.closeRes = "ok"; this.destroyCurrentForm(currentForm); this.close(); }, this);
        currentForm.onApply(params);
      }
  JS

  js_method :on_save_draft, <<-JS
      function(params){
        this.onOk({draft_save: true});
      }
  JS

  js_method :on_cancel, <<-JS
    function(params){
      var currentForm = this.items.first();
      if(currentForm.visitForm == true){
        if(currentForm.isDirty()){
          Ext.MessageBox.confirm("Confirmation", "Your changes have not been saved. Would you like to save them now?", function(btn){
          if(btn == "yes"){
            this.onOk();
          }else{
            this.close();
           }
        }, this);
        }else{
          this.close();
        }
      } else{
        this.close();
      }

/*
      var msg = "Are you sure you want to cancel the changes you made?";
      var doc = Ext.ComponentQuery.query('#document_cancel_id')[0];
      if(doc !=null || doc != undefined){
        Ext.Msg.confirm('Warning', msg, function(btn){
          if (btn == 'yes'){
            this.close();
          }
        }, this);
      }else{
        this.close();
      }
*/
   }
  JS

  action :cancel do
    {text: '',tooltip: "Cancel", icon: :cancel_new}
  end

  action :ok do
    {text: "",tooltip: "Save", icon: :save_new}
  end

  action :save_and_new do
    { :text => "Save & New"}
  end

  action :save_draft do
    {text: "Save Draft" , tooltip: "Save Draft" }
  end

  def deliver_component_endpoint(params)
    debug_log session
    component_params = params[:component_params] || {}
    new_params = js_hash_to_ruby_hash(component_params)
    components[params[:name].to_sym].merge!(new_params)
    super
  end
end
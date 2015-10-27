class FieldStaffWorkQueue < ActiveRecord::Base

  def self.data(user, filter = nil)
    treatments = PatientTreatment.fs_treatment_scope
    output_data = []
    treatments.each{|treatment|
      fs_visits = treatment.treatment_visits.user_scope(user)
      fs_visits.each{|v|
        unless v.route_sheet_present?
          #Visits pending Routesheet
          output_data <<
              {id: v.id,
               record_type: :visit, action_type: :routesheet,
               item_date: v.visit_start_time,
               category: "Visit",
               agency: "#{treatment.health_agency_name}",
               patient: v.treatment.patient.full_name,
               item_description: "#{v.visit_type.to_s}",
               action_required: "Pending Routesheet",
               aging: get_aging(v.visit_date)
              }.values
        end

        pending_docs = v.pending_documents(['QA', 'A', 'E'])
        pending_docs.each{|d|
          #Visits pending Documentation
          next if d.field_signature_not_required?
          next if (d.field_staff == User.current and d.field_staff_signature_required? == false)
          next if (d.supervised_user == User.current and d.supervisor_signature_required? == false)
          next if (d.field_staff == User.current and d.field_staff_is_dependent? == true and d.health_agency_co_sign_optional? == true)
          action_required = d.get_pending_status
          output_data << {id: d.id, record_type: :document, action_type: :document,
                          item_date: v.visit_start_time,
                          category: "Document",
                          agency: "#{treatment.health_agency_name}",
                          patient: v.treatment.patient.full_name,
                          item_description: d.document_name,
                          action_required: action_required,
                          aging: get_aging(v.visit_date)
          }.values
        }
      }

      #Non-visit documents sign required
    pending_docs = treatment.documents.where("status not in (?) and visit_id is null", ["A", "E", "QA"])
    pending_documents = pending_docs.where("field_staff_id = ? or supervised_user_id = ?", user.id, user.id)

      pending_documents.each do |doc|
        next if doc.field_signature_not_required?
        next if (doc.field_staff == User.current and doc.field_staff_signature_required? == false)
        next if (doc.supervised_user == User.current and doc.supervisor_signature_required? == false)
        next if (doc.field_staff == User.current and doc.field_staff_is_dependent? == true and doc.health_agency_co_sign_optional? == true)
        action_required = doc.get_pending_status
        output_data << {id: doc.id, record_type: :document, action_type: :document,
                        item_date: convert_date_to_time(doc.document_date),
                        category: "Document",
                        agency: "#{doc.treatment.health_agency_name}",
                        patient: doc.treatment.patient.full_name,
                        item_description: "#{doc.document_name}",
                        action_required: action_required,
                        aging: get_aging(doc.document_date)
        }.values
      end

      output_data += treatment.communication_notes.includes(:treatment).where(["note_status = ? AND created_user_id = ?", 'D', user]).collect{|c|
        #Communication Notes pending Signature
        {id: c.id, record_type: :communication_note, action_type: :communication_note,
         item_date: c.note_date_time,
         category: "Communication Note",
         agency: "#{treatment.health_agency_name}",
         patient: c.treatment.patient.full_name,
         item_description: "Communication Note",
         action_required: "Pending Signature",
         aging: get_aging(c.note_date_time)
        }.values
      }

      output_data += treatment.medical_orders.includes(:treatment).where(["order_status = ? AND field_staff_id = ?", 'D', user.id]).collect{|order|
        #Medical Order pending Signature
        {id: order.id, record_type: :medical_order, action_type: :medical_order,
         item_date: order.order_date,
         category: "Order",
         agency: "#{treatment.health_agency_name}",
         patient: order.treatment.patient.full_name,
         item_description: "#{order.order_type_display}",
         action_required: "Pending Signature",
         aging: get_aging(order.order_date)
        }.values
      }
    }
    output_data.sort{|a,b|b.last <=> a.last}
  end

  def self.convert_date_to_time(date)
    date.strftime("%m/%d/%Y") if date
  end

  def self.get_aging(date)
    date = Date.strptime(date, '%m/%d/%Y') if date.is_a? String
    date ? (Date.current - date) : 0
  end

end
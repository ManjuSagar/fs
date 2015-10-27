class HealthAgencyWorkQueue < ActiveRecord::Base

  COLUMN_MAP = ["id", "record_type", "action_type", "item_date", "category", "field_staff", "patient", "item_description", "action_required", "aging"]

  def self.data(user, filter = nil)
    output_data = []
    draft_visits = TreatmentVisit.not_draft

    draft_visits.each{|v|
      unless v.route_sheet_present?
        #Visits pending Routesheet
        output_data <<
        {id: v.id,
         record_type: :visit, action_type: :routesheet,
         item_date: v.visit_start_time,
         category: "Visit",
         field_staff: v.visited_user.full_name,
         patient: v.treatment.patient.full_name,
         item_description: "#{v.visit_type.to_s}",
         action_required: "Pending Routesheet",
         aging: get_aging(v.visit_date)
        }.values
      end
    }

    pending_docs = Document.org_scope.includes(:treatment_visit).where(["documents.status not in (?) and treatment_visits.draft_status = ?", ['A', 'E'], false])
    pending_docs.each{|d|
      #Visits pending Documentation
      action_required = d.get_pending_status
      visit = d.treatment_visit
      output_data << {id: d.id, record_type: :document, action_type: :document,
                      item_date: visit.visit_start_time,
                      category: "Document",
                      field_staff: visit.visited_user.full_name,
                      patient: d.treatment.patient.full_name,
                      item_description: d.document_name,
                      action_required: action_required,
                      aging: get_aging(visit.visit_date)
      }.values
    }

    #Non-visit documents sign required
    pending_documents = Document.org_scope.where(["documents.status not in (?) and visit_id is null", ["A", "E"]])

    pending_documents.each do |doc|
      action_required = doc.get_pending_status
      output_data << {id: doc.id, record_type: :document, action_type: :document,
                      item_date: convert_date_to_time(doc.document_date),
                      category: "Document",
                      field_staff: doc.field_staff.full_name,
                      patient: doc.treatment.patient.full_name,
                      item_description: "#{doc.document_name}",
                      action_required: action_required,
                      aging: get_aging(doc.document_date)
      }.values
    end

    #Communication Notes Signature
    agency_comm_notes = CommunicationNote.org_scope.where(["communication_notes.note_status = ? AND communication_notes.created_user_id = ?", 'D', User.current.id])
    output_data += agency_comm_notes.collect{|c|
       {id: c.id, record_type: :communication_note, action_type: :communication_note,
        item_date: c.note_date_time,
        category: "Communication",
        field_staff: (c.field_staff ? c.field_staff.full_name : ''),
        patient: c.treatment.patient.full_name,
        item_description: "Communication Note",
        action_required: "Office Staff",
        aging: get_aging(c.note_date_time)
       }.values

    }

    orders = MedicalOrder.org_scope.where(["order_status = ? AND field_staff_id = ?", 'D', User.current.id])
    output_data += orders.collect{|order|
      #Medical Order pending Signature
      {id: order.id, record_type: :medical_order, action_type: :medical_order,
       item_date: order.order_date,
       category: "Order",
       field_staff: (order.field_staff ? order.field_staff.full_name : ''),
       patient: order.treatment.patient.full_name,
       item_description: "#{order.order_type_display}",
       action_required: "Pending Signature",
       aging: get_aging(order.order_date)
      }.values
    }

    unless filter.nil?
      filter = ActiveSupport::JSON.decode(filter)
      column_positions = filter.collect{|f| COLUMN_MAP.index(f["field"])}
      filter_values = filter.collect{|f| f["value"]}
      output_data.select!{|output|
        result = true
        column_positions.each_with_index{|position, index|
          next if filter_values[index].to_s == "---"
          result = if output[position].class.name == "String"
                      result && output[position].upcase.include?(filter_values[index].upcase)
                   elsif output[position].class.name == "Rational"
                     result && output[position] == filter_values[index].to_i
                   end
        }
        result
      }
    end

    output_data.sort{|a,b|b.last <=> a.last}   #Order by Aging factor
  end


  def self.convert_date_to_time(date)
    date.strftime("%m/%d/%Y") if date
  end

  def self.get_aging(date)
    date = Date.strptime(date, '%m/%d/%Y') if date.is_a? String
    date ? (Date.current - date.to_date) : 0
  end

end
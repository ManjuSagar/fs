class PhysicianEditForm < Mahaswami::FormPanel

  def initialize(conf = {}, parent_id = nil)
      super
      @physician = OrgPhysician.find_by_org_id_and_physician_id(Org.current.id, config[:record_id]) if config[:record_id]
      component_session[:physician_id] = @physician.id if @physician
  end


  def configuration
    c = super
    set_read_only = false
    phy = OrgPhysician.where(id: c[:record_id]).first.physician if c[:record_id]
    phy ||= Physician.find(c[:strong_default_attrs][:physician_id])
    c.merge(
      model: "OrgPhysician",
      cityStatePrefill: false,
      #item_id: 'physician_form',
      items: [{
          border: false,
          margin: '0 0 5% 0',
          items: [{
              border: false,
              layout: :hbox,
              style: 'margin: 0 0 5% 1%;',
              bodyStyle: 'padding-top: 10px; padding-right: 1%',
              items: [
                  {name: :npi_number, field_label: 'Search Physician', flex: 2, xtype: :netzkeremotecombo, hide_trigger: true,
                   read_only: true, value: phy.npi_number, enable_key_events: true, margin: "0 4% 0 0", allow_blank: false,
                   label_width: '50%', item_id: 'npi_number'},
                  {name: :pecos_verification, field_label: 'PECOS Verification',  item_id: "pecosVerification", flex: 1,
                   margin: "0 0 0 5%", value: phy.pecos_verification, xtype: :checkbox, label_width: '170%', read_only: true}
              ]
          },
          {
              border: false,
              layout: :hbox,
              style: 'margin-left: 1%;',
              bodyStyle: 'padding-top: 10px; padding-right: 1%',
              items: [
                  {name: :first_name, field_label: 'Name', value: phy.first_name, emptyText: 'First Name', allow_blank: false,
                    flex: 3, label_width: '67%', margin: "0 5% 0 0", read_only: true, item_id: 'firstName'},
                  {name: :last_name, field_label: '', value: phy.last_name, emptyText: 'Last Name', flex: 1.8,
                    margin: "0 5% 0 0", read_only: true, item_id: 'lastName'},
                  {name: :suffix, field_label: '', emptyText: 'Suffix', flex: 0.6, item_id: 'suffix'},
              ]
          },
          {
              border: false,
              layout: :hbox,
              style: 'margin-left: 1%;',
              bodyStyle: 'padding-top: 10px; padding-right: 1%',
              items: [
                  {name: :street_address, field_label: 'Address', emptyText: 'Street Address',
                    label_width: '33%',flex: 4.7, margin: "0 5% 0 0", allow_blank: false, item_id: 'streetAddress'},
                  {name: :suite_number, field_label: '', emptyText: 'Suite #', flex: 0.58, item_id: 'suiteNumber'}
              ]
          },
          {
              border: false,
              layout: :hbox,
              style: 'margin-left: 1%;',
              bodyStyle: 'padding-top: 10px; padding-right: 1%',
              items: [
                  {name: :city, field_label: 'City/State/Zip', flex: 5.5, emptyText: 'City', label_width: '46%',
                   margin: "0 5% 0 0", allow_blank: false, item_id: 'city'},
                  {name: :state, field_label: '', xtype: 'combo', flex: 1.4, emptyText: 'State', margin: "0 5% 0 0",
                   store: State.all.collect{|x|[x.state_code, x.state_description]}, item_id: 'state', editable: false},
                  {name: :zip_code, field_label: '', flex: 0.85, emptyText: 'ZIP Code', item_id: 'zipCode'}
              ]
          },
          {
              border: false,
              layout: :hbox,
              style: 'margin-left: 1%;',
              bodyStyle: 'padding-top: 10px; padding-right: 1%',
              items: [
                  {name: :phone_number, field_label: 'Phone', flex: 3.9, label_width: '81%',  margin: "0 5% 0 0",
                   emptyText: "Primary Phone", item_id: 'phoneNumber1', input_mask: '(999) 999-9999'},
                  {name: :personal_phone_number_1, field_label: '', flex: 2, emptyText: "Alternate Phone", margin: "0 5% 0 0",
                   input_mask: '(999) 999-9999', item_id: 'phone_number_2', value: component_session[:contact_1]},
                  {name: :fax_number, field_label: '', flex: 2, value: phy.fax_number, input_mask: '(999) 999-9999',
                    emptyText: 'Fax', label_separator: '', item_id: 'faxNumber'},
              ]
          },
          {
              border: false,
              layout: :hbox,
              style: 'margin-left: 1%;',
              bodyStyle: 'padding-top: 10px; padding-right: 1%',
              items: [
                  {name: :email, field_label: 'Email', emptyText: 'Email Address',width: '75%', label_width: '41%',
                   allow_blank: true, item_id: 'email', value: phy.email, vtype: 'email'}
              ]
          }]
      }]
    )
  end
end

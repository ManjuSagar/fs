# Custom user form (predefined model and layout)
class OrgContactForm < Mahaswami::FormPanel

  def configuration
    super.merge(
        model: "OrgContact",
        items: [
            {:name => :contact_first_name, :field_label => "First Name"},
            {:name => :contact_last_name, :field_label => "Last Name"},
            {:name => :phone_number, :field_label => 'Phone Number', input_mask: '(999) 999-9999'},
            {:name => :extension, :field_label => "Extn."},
            {:name => :email, :field_label => "Email"},
        ]
    )
  end
end
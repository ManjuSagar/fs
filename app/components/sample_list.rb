class SampleList < Mahaswami::FormPanel

  def get_records(params)
    [User.first]
  end

  def configuration
    super.merge(
        model: 'User',
        title:  "User",
        columns: [
            {name: :married_flag, header: "First Name", editable: true},
            {name: :first_name, header: "First Name", editable: false},
            {name: :last_name, header: "Last Name", editable: false},
        ]
    )
  end

end
class Documents::Oasis::MedicationPocDocument < Mahaswami::SubPanel
  def configuration
    super.merge(
        autoScroll: true,
        layout: 'fit',
        border: 0,
        items:[
            {
                xtype: 'tabpanel',
                border:0,
                deferredRender: false,
                items:[
                    :allergies.component,
                    :infusion.component,
                    :iv_supplies.component,
                    :medicational_status.component
                ]
            }

        ]


    )
  end
  component :allergies do
    {
        class_name: "Documents::Oasis::Allergies",
        title: 'Allergies'
    }
    end
  component :infusion do
    {
        class_name: "Documents::Oasis::Infusion",
        title: 'Infusion'
    }
    end
  component :iv_supplies do
    {
        class_name: "Documents::Oasis::IvSupplies",
        title: 'IV Supplies'
    }
  end
  component :medicational_status do
    {
        class_name: "Documents::Oasis::MedicationStatus",
        title: 'Medication Status'
    }
  end

end
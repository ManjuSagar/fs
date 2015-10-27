class Documents::Oasis::AdliadLs4PocDocument < Mahaswami::SubPanel
  def configuration
    super.merge(
        layout: 'fit',
        border: 0,
        items:[
            {
                xtype: 'tabpanel',
                deferredRender: false,
                border:0,
                items:[
                    :musculoskeletal.component,
                    :activities_permitted.component,
                    :supplies_equipment.component,
                    :functional_limitations.component,
                    :fall_risk_management.component
                ]
            }

        ]
    )


  end
  component :musculoskeletal do
    {
        class_name: "Documents::Oasis::Musculoskeletal",
        title: 'Musculoskeletal'
    }
  end
  component :activities_permitted do
    {
        class_name: "Documents::Oasis::ActivitiesPermitted",
        title: 'Activities Permitted'
    }
  end
  component :supplies_equipment do
    {
        class_name: "Documents::Oasis::SuppliesEquipment",
        title: 'Supplies Equipment'
    }
  end
  component :functional_limitations do
    {
        class_name: "Documents::Oasis::FunctionalLimitations",
        title: 'Functional Limitations'
    }
    end
  component :fall_risk_management do
    {
        class_name: "Documents::Oasis::FallRiskManagement",
        title: 'Fall Risk Management'
    }
  end
end
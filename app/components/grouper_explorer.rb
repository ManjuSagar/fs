class GrouperExplorer < Netzke::Base
  include ActionView::Helpers::NumberHelper
  def configuration
    s = super
    doc = Document.find(s[:record_id]) if s[:record_id]
    episode = if s[:episode_id]
                 TreatmentEpisode.find(s[:episode_id])
               else
                 TreatmentEpisode.find(s[:strong_default_attrs][:treatment_episode_id])
               end
    params = HippsGrouperPoints.get_hipps_code_and_grouping_points(doc, s[:model], s[:strong_default_attrs], s[:values], episode)
    hipps_code = params[:hipps_code]
    bill_amount = params[:bill_amount]
    s.merge(
        strong_default_attrs: params,
        margin: "5 5 10 5",
        items: [
            {   xtype: :panel,
                layout: :hbox,
                header: false,
                border: false,
                align: :stretch,
                items: hipps_code_details(hipps_code, bill_amount)

            },
            :grouper.component
        ]
    )
  end

  component :grouper do
    {
        :class_name => 'Grouper',
        record_id: config[:record_id],
        strong_default_attrs: config[:strong_default_attrs],
        model: config[:model]
    }
  end


  def hipps_code_details(hipps_code, bill_amount)
    values = User.current.office_staff? ? {hipps_code: ['HCPCS', hipps_code], amount: ['Amount', bill_amount]} : {hipps_code: ['HCPCS', hipps_code]}
    list = []
    values.each_pair do |key, value|

      list << {
          xtype: :panel,
          border: false,
          layout: 'hbox',
          align: :stretch,
          defaults:{
              style:"font-weight: bold;"
          },
          items:[{
                     xtype: 'label',
                     text: value[0],
                     margin: '0 0 0 20',
                     width: (value[0] == 'HCPCS' ? 45 : 50),
                 }, {
                     xtype: "label",
                     text: ":",
                     width: 5

                 },{
                     xtype: 'label',
                     width: 80,
                     text: value[1],
                 }
          ]
      }
    end
    list
  end


end
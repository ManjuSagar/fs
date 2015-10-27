class HippsGrouperChart < Mahaswami::Panel
  include ActionView::Helpers::NumberHelper
  def configuration
    s = super
    doc = Document.find(s[:record_id]) if s[:record_id]
    @episode = if s[:episode_id]
                TreatmentEpisode.find(s[:episode_id])
              else
                TreatmentEpisode.find(s[:strong_default_attrs][:treatment_episode_id])
              end
    params = get_hipps_code_and_grouping_points(doc, s[:model],s[:strong_default_attrs], s[:values])
    year = @episode.start_date.year
    hipps_code = params[:hipps_code]
    bill_amount = params[:bill_amount]
    grouping_points = params[:grouping_points].present? ? params[:grouping_points] : []
    display_group_values = Document.const_get("grouping_points_#{year}".upcase)
    grouping_values = grouping_points.present? ? display_group_values[grouping_points[0]] : display_group_values['1']

    s.merge(
        header: false,
        border: false,
        region: :center,
        items:[
            {   xtype: :panel,
                layout: :hbox,
                header: false,
                border: false,
                align: :stretch,
                items: hipps_code_details(hipps_code, bill_amount)

            },

            {
                xtype: :panel,
                layout: :hbox,
                border: false,
                margin: '0 0 10 110',
                defaults:{
                    xtype: :panel,
                    header: false,
                    border: false,
                    layout: {
                        type: 'column',
                    },
                },
                items: [
                    {
                        width: '13%',
                        margin: '15 0 0 10',
                        items: grouping_step(grouping_points[0])
                    },
                    {
                        width: '4%',
                        margin: '50 0 0 0',
                        items: timing_equation(grouping_points[0]),

                    },
                    {
                        width: '13%',
                        margin: '15 0 0 10',
                        items: clinical_group(grouping_values['C'], grouping_points[1]),

                    },
                    {
                        width: '4%',
                        margin: '50 0 0 0',
                        items: clinical_points(grouping_values['C'], grouping_points[1]),

                    },
                    {
                        width: '13%',
                        margin: '15 0 0 10',
                        items: functional_group(grouping_values['F'], grouping_points[2]),

                    },
                    {
                        width: '4%',
                        margin: '50 0 0 0',
                        items: functional_points(grouping_values['F'], grouping_points[2]),

                    },
                    {
                        width: '13%',
                        margin: '15 0 0 10',
                        items: service_group(grouping_values['S'],grouping_points[3]),

                    },
                    {
                        width: '4%',
                        margin: '50 0 0 0',
                        items: service_points(grouping_values['S'], grouping_points[3]),

                    },
                    {
                        width: '13%',
                        margin: '15 0 0 10',
                        items: nrs_group(grouping_points[4]),

                    },
                    {
                        width: '4%',
                        margin: '50 0 0 0',
                        items: nrs_points(grouping_points[4]),

                    }

                ]
            }
        ]

    )
  end

  def hipps_code_details(hipps_code, bill_amount)
    values = {hipps_code: ['HCPCS', hipps_code], amount: ['Amount', bill_amount]}
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
                     width: 60,
                 }, {
                     xtype: "label",
                     text: ":",
                     width: 20

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

  def label_text(text)
    {
        xtype: 'label',
        text: text,
        margin: '10 0 10 6',
        style:'font-size:10px;',

    }
  end

  def grouping_step(points)
    values = ['1', '2','3','4','5']
    list = []
    list << label_text('Grouping Step')
    return nil if values.nil?
    values.each_with_index do |value, index|
      style = ((points.present? and value == points.strip) ? 'cTextAlignAndColor' : 'cTextAlign')
      list <<  {
          xtype: 'textfield',
          width: 90,
          height: 30,
          readOnly: true,
          margin: '0 0 0 0',
          fieldCls: style,
          value: value
      }

    end
    list
  end

  def timing_equation(points)
    values = ['1', '2','3','4','5']
    list = []
    return nil if values.nil?
    values.each_with_index do |value, index|
      value = ((points.present? and value == points.strip) ? value : ' ')
      list <<  {
          xtype: 'textfield',
          width: 70,
          height: 30,
          fieldStyle:"border:none 0px black; font-weight: bold;",
          readOnly: true,
          margin: '0 0 0 0',
          value: value
      }

    end
    list
  end

  def clinical_group(values, points)
    # values = ['9+ C', '5-8 B','0-4 A']
    list = []
    return nil if values.nil?
    list << label_text('Clinical Points')
    values.each_with_index do |value, index|
      style = group_style(value, points)
      list <<  {
          xtype: 'textfield',
          width: 90,
          height: 50,
          readOnly: true,
          margin: '0 0 0 0',
          fieldCls: style,
          value: value
      }

    end
    list
  end

  def clinical_points(values, points)
    # values = ['9+ C', '5-8 B','0-4 A']
    list = []
    return nil if values.nil?
    values.each_with_index do |value, index|
      style, cl_points = get_point_style(value, points)
      list <<  {
          xtype: 'textfield',
          width: 70,
          height: 50,
          fieldStyle: style,
          readOnly: true,
          margin: '0 0 0 0',
          value: cl_points
      }
    end
    list

  end
  def functional_group(values, points)
    # values = ['7+ H', '6 G','0-5 F']
    list = []
    return nil if values.nil?
    list << label_text('Functional Points')
    values.each_with_index do |value, index|
      style = group_style(value, points)
      list <<  {
          xtype: 'textfield',
          width: 90,
          height: 50,
          readOnly: true,
          margin: '0 0 0 0',
          fieldCls: style,
          value: value
      }

    end
    list

  end

  def functional_points(values, points)
    # values = ['7+ H', '6 G','0-5 F']
    list = []
    return nil if values.nil?
    values.each_with_index do |value, index|
      style, fn_points = get_point_style(value, points)
      list <<  {
          xtype: 'textfield',
          width: 70,
          height: 50,
          fieldStyle: style,
          readOnly: true,
          margin: '0 0 0 0',
          value: fn_points
      }

    end
    list

  end
  def service_group(values, points)
    # values = ['11-13 P', '10 N','7-9 M','6 L','0-5 K']
    list = []
    return nil if values.nil?
    list << label_text('Service Points')
    flag_for_coloring = values.include? 'N/A'
    values.each_with_index do |value, index|
      style = group_style(value, points, flag_for_coloring)
      list <<  {
          xtype: 'textfield',
          width: 90,
          height: 30,
          readOnly: true,
          margin: '0 0 0 0',
          fieldCls: style,
          value: value
      }

    end
    list
  end

  def service_points(values, points)
    # values = ['11-13 P', '10 N','7-9 M','6 L','0-5 K']
    list = []
    return nil if values.nil?
    flag_for_coloring = values.include? 'N/A'
    values.each_with_index do |value, index|
      style, s_points = get_point_style(value, points, flag_for_coloring)
      list <<  {
          xtype: 'textfield',
          width: 70,
          height: 30,
          fieldStyle:"border:none 0px black; font-weight: bold;",
          readOnly: true,
          margin: '0 0 0 0',
          value: s_points
      }

    end
    list
  end
  def nrs_group(points)
    values = ['99+ X', '49-98 W','28-48 V','1-14 T','0 S']
    list = []
    return nil if values.nil?
    list << label_text('NRS Supply Points')
    values.each_with_index do |value, index|
      style = group_style(value, points)
      list <<  {
          xtype: 'textfield',
          width: 90,
          height: 30,
          readOnly: true,
          margin: '0 0 0 0',
          fieldCls: style,
          value: value
      }

    end
    list
  end

  def nrs_points(points)
    values = ['99+ X', '49-98 W','28-48 V','1-14 T','0 S']
    list = []
    return nil if values.nil?
    values.each_with_index do |value, index|
      style, nr_points = get_point_style(value, points)
      list <<  {
          xtype: 'textfield',
          width: 70,
          height: 30,
          fieldStyle: style,
          readOnly: true,
          margin: '0 0 0 0',
          value: nr_points
      }

    end
    list
  end

  def group_style(value, points, flag_for_coloring = false)
    return 'cTextAlign' if value.nil? || points.nil?
    value = value.split(' ').first
    style = if ((value.include? '+') && value.chomp('+').to_i <= points.to_i)
              "cTextAlignAndColor"
            elsif (value.to_i == points.to_i)
              "cTextAlignAndColor"
            elsif (value.length == 2 && flag_for_coloring == true && value.length <= points.to_i)
              "cTextAlignAndColor"
            elsif (value.split('-')[0].to_i..value.split('-')[1].to_i).include? points.to_i
              "cTextAlignAndColor"
            else
              "cTextAlign"
            end
    style
  end

  def get_point_style(value, points, flag_for_coloring = false)
    return ['border:none 0px black;', ' '] if value.nil? || points.nil?
    value = value.split(' ').first
    if ((value.include? '+') && value.chomp('+').to_i <= points.to_i)
      style = "border:none 0px black; font-weight: bold;"
      group_points = points
    elsif (value.to_i == points.to_i)
      style = "border:none 0px black; font-weight: bold;"
      group_points = points
    elsif (value.length == 2 && flag_for_coloring == true && value.length <= points.to_i)
      style = "border:none 0px black; font-weight: bold;"
      group_points = points
    elsif (value.split('-')[0].to_i..value.split('-')[1].to_i).include? points.to_i
      style = "border:none 0px black; font-weight: bold;"
      group_points = points
    else
      style = 'border:none 0px black;'
      group_points = ' '
    end
    [style, group_points]
  end

  def get_hipps_code_and_grouping_points(doc, model, attrs, values)
    result = {}
    doc = if doc.present?
            doc
          else
            doc_form_template_id = DocumentDefinition.where(id: attrs[:document_definition_id]).first.document_form_template_id
            model.constantize.new({document_definition_id: attrs[:document_definition_id],                                        document_form_template_id: doc_form_template_id,
                                            treatment_id: attrs[:treatment_id],
                                            treatment_episode_id: attrs[:treatment_episode_id]})
          end
    if doc
      doc.data = values.stringify_keys if values.present?     
      score, bill_amount = @episode.score_hipps_code_and_bill_amount({doc: doc, regenerate_hipps_code: true, hipps_code: result[1]}) if @episode
      result = if score and score.hipps_code.present?
                 bill_amount = bill_amount ? number_to_currency(bill_amount) : 0
                 {hipps_code: score.hipps_code, bill_amount: bill_amount, grouping_points: score.grouping_points}
               else
                 hipps_code = 'NA'
                 bill_amount = 'NA'
                 {hipps_code: hipps_code, bill_amount: bill_amount, grouping_points: []}
               end

    end
    result
  end

end
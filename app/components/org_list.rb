class OrgList < Mahaswami::GridPanel

  def initialize(conf = {}, parent = nil)
    super
    if component_session[:org_type] == "HealthAgency"
      components[:edit_form][:items].first.merge!(:class_name => "HealthAgencyForm")
      components[:edit_form].merge!(:title => "Edit Health Agency")
    end
  end

  def configuration
    super.merge(
      model: 'Org',
      title: "Clients",
      add_form_window_config:{
        title: "Add Organization",
        autowidth: false,
        autoHeight: false,
        width: "90%",
        height:"90%"

      },
      edit_form_window_config:{
        title: "Edit Organization",
        autowidth: false,
        autoHeight: false,
        width: "90%",
        height: "100%",

      },
      columns: [
          { name: :org_name, header: "Name", editable: false, width: 165},
          { name: :org_type, header: "Type", editable: false,
            getter: lambda {|r|
              Org::ORG_TYPES.each do |type|
                return type[1] if type[0] == r.org_type
              end
            }
          },
          { name: :org_package, header: "Package", editable: false,
            getter: lambda {|r|
              Org::ORG_PACKAGES.each do |pack|
                return pack[1] if pack[0] == r.org_package
              end
            }
          },
          { name: :email, width: 200, editable: false}
      ],
      scope: {draft_status: false}
    )
  end

  def default_bbar
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  def default_context_menu
    [:add_in_form.action, :edit_in_form.action, :del.action]
  end

  action :add_in_form, text: "Add Client"
  action :edit_in_form, text: "Edit Client"

  js_method :init_component, <<-JS
    function(){
      this.callParent();
      // setting the 'rowclick' event
     this.on('itemclick', function(view, record){
        this.selectRecord({org_id: record.get('id')});
      }, this);

      this.getSelectionModel().on('selectionchange', function(selModel){
      }, this);

    }
  JS

  add_form_config         class_name: "NewOrgForm"
  edit_form_config        class_name: "OrgForm"
  multi_edit_form_config  class_name: "OrgForm"

  def default_fields_for_forms
    #puts data_class.instance_methods.join(",")
    selected_columns = columns.select do |c|
      data_class.column_names.include?(c[:name]) ||
          data_class.instance_methods.include?("#{c[:name]}=".to_sym) ||
          association_attr?(c[:name])
    end

    selected_columns.map do |c|
      field_config = {
          :name => c[:name],
          :field_label => c[:text] || c[:header]
      }

      # scopes for combobox options
      field_config[:scopes] = c[:editor][:scopes] if c[:editor].is_a?(Hash)

      field_config.merge!(c[:editor] || {})

      field_config
    end
  end

  endpoint :select_record do |params|
    component_session[:org_type] = Org.find(params[:org_id]).org_type
  end
end
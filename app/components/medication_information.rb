class MedicationInformation < Mahaswami::Panel

  def configuration
    s = super
    drugs = FdaDrugLibrary.where(drug_name: s[:drug_name].split(" (").first.upcase)
    s.merge(
        header: false,
        items: [],
        autoScroll: true,
        height: 500,
        html: get_html_content(s[:drug_name], drugs)
    )
  end

  def get_html_content(drug_name, drugs)
      "<div class='drug_info'>
        <table border='0' cellspacing='0' width='600' summary='Drugs by Application Number data table' cellpadding='2', text-align='center'>
           <tbody>
             <tr>
                <td width='40%' bgcolor='#E2EAF2'><b>&nbsp;Drug Name(s)</b></td>
                <td width='60%' bgcolor=white><b>&nbsp;&nbsp;#{drug_name.split(' (').first}</b></td>
              </tr>
              <tr height='5'></tr>
             <tr>
                <td width='40%' bgcolor='#E2EAF2'><b>&nbsp;Active Ingredients</b></td>
                <td width='60%' bgcolor=white><b>&nbsp;&nbsp;#{drugs.first.active_ingredients}</b></td>
              </tr>
              <tr height='5'></tr>
             <tr>
                <td width='40%' bgcolor='#E2EAF2'><b>&nbsp;Form(s) and Strength(s) Available</b></td>
                <td width='60%' bgcolor=white><b>
                  #{strength_and_forms_available(drugs)}</b>
                </td>
              </tr>
            </tbody>
        </table><br/><br/>

        <table border='1' cellspacing='0' width='600' summary='Drugs by Application Number data table' cellpadding='2', text-align='center', class='table_info'>
           <tbody>
             <tr>
                <th width='25%'>Company</th>
                <th width='25%'>Dosage Form/Route</th>
                <th width='25%'>Strength</th>
                <th width='25%'>Marketing Status</th>
            </tr>" +

            drugs.collect{|d|
              "<tr>
              <td width='25%'>#{d.company.name}</td>
              <td width='25%'>#{d.form.form}</td>
              <td width='25%'>#{d.strength}</td>
              <td width='25%'>#{d.marketing_status}</td>
            </tr>"
            }.join("\n") +
          "</tbody>
        </table>
      </div>"
  end

  def strength_and_forms_available(drugs)
    str = ""
    forms = drugs.map(&:form_id).uniq
    forms.each{|form_id|
      str += "&nbsp;&nbsp;*&nbsp;&nbsp;" + DosageForm.find(form_id).form + "<b> : </b>" + drugs.where(form_id: form_id).map(&:strength).uniq.join(";") + "<br/>"
    }
    str
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();
    }
  JS

end
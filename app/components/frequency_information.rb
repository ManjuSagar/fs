class FrequencyInformation < Mahaswami::Panel

  def configuration
    s = super
    s.merge(
        header: false,
        items: [],
        autoScroll: true,
        html: get_html_content(s[:where_its_used])
    )
  end

  def get_html_content(where_its_used)
    res = ""
    res += "<div style='margin:5px'>Multiple frequencies can be entered using space/comma separator.</div>" if where_its_used == :visit_edit_form
    res += "<div class='drug_info'>
      <table border=1>
        <tr>
          <th><b>Frequency</b></th>
          <th><b>Examples</b></th>
        </tr>
        <tr>
          <td style='padding:2px'><b><i>Number of one daily visit</i></b></td>
          <td style='padding:2px'><b>QDX3</b> : Three days single visit daily<br/><br/><b>QDX2</b> : Two days single visit daily</td>
        </tr>
        <tr>
          <td style='padding:2px'><b><i>Number of two daily visits</i></b></td>
          <td style='padding:2px'><b>BIDX3</b> : Three days two visits daily<br/><br/><b>BIDX2</b> : Two days two visits daily</td>
        </tr>
        <tr>
          <td style='padding:2px'><b><i>Number of three daily visits</i></b></td>
          <td style='padding:2px'><b>TIDX3</b> : Three days three visits daily<br/><br/><b>TIDX2</b> : Two days three visits daily</td>
        </tr>
        <tr>
          <td style='padding:2px'><b><i>Number of visits per day</i></b></td>
          <td style='padding:2px'><b>1D3</b> : Three days one visit daily<br/><br/><b>2DAY5</b> : Five days two visits daily<br/><br/><b>3DAY4</b> : Four days three visits daily</td>
        </tr>
        <tr>
          <td style='padding:2px'><b><i>Number of visits per week</i></b></td>
          <td style='padding:2px'><b>1W3</b> : Three weeks one visit per week<br/><br/><b>2WK5</b> : Five weeks two visits per week<br/><br/><b>3WEEK4</b> : Four weeks three visits per week</td>
        </tr>
        <tr>
          <td style='padding:2px'><b><i>Number of visits per month</i></b></td>
          <td style='padding:2px'><b>4M1</b> : One month four visits<br/><br/><b>2MON2</b> : Two months two visits per month<br/><br/><b>6MT1</b> : One month six visits<br/><br/><b>8MONTH1</b> : One month eight visits</td>
        </tr>
      </table>
    </div>"
    res
  end

end
include ActionView::Helpers::NumberHelper
class HippsGrouperPoints

  def self.get_hipps_code_and_grouping_points(doc, model, attrs, values, episode)
    result = {}
    year = episode.start_date.year
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
      score, bill_amount = episode.score_hipps_code_and_bill_amount({doc: doc, regenerate_hipps_code: true, hipps_code: result[1]}) if episode
      result = if score and score.hipps_code.present?
                 bill_amount = bill_amount ? number_to_currency(bill_amount) : 0
                 {hipps_code: score.hipps_code, bill_amount: bill_amount, grouping_points: score.grouping_points}
               else
                 hipps_code = 'NA'
                 bill_amount = 'NA'
                 {hipps_code: hipps_code, bill_amount: bill_amount}
               end

    end
    box_values = get_all_box_values(result[:grouping_points], year)
    res = result.merge(box_values)
    res
  end

  def self.get_all_box_values(points, year)
    points = points.present? ? points : []
    b1 = get_box1_results(points)
    res = HippsGrouperPoints.const_get("grouping_points_#{year}".upcase)
    episode_timing =  res[points[0]] || res["1"]

    b2 = get_box_results(episode_timing['C'], points[1])
    b3 = get_box_results(episode_timing['F'], points[2])
    b4 = get_box_results(episode_timing['S'], points[3])
    b5_values = ['99+ X', '49-98 W','28-48 V', '15-27 U', '1-14 T','0 S']
    b5 = get_box_results(b5_values, points[4])
    boxes = {b1: b1, b2: b2, b3: b3, b4: b4, b5: b5}
  end

  def self.get_box1_results(points)
    b1 = []
    ['1', '2', '3', '4', '5'].each do |x|
      b1 << ["#{x}", get_box1_value(x, points)]
    end
    b1
  end

  def self.get_box_results(values, points)
    b = []
    flag = values.include? 'N/A'
    values.each do |x|
      val = get_box_value(x, points, flag)
      res = (val == 0 ? -1 :val)
      b << ["#{x}",  res]
    end
    b
  end

  def self.get_box1_value(inside_value, points)
    b1_value = points[0]
    (inside_value == b1_value ? b1_value : '')
  end

  def self.get_box_value(inside_value, outside_value, flag = false)
    return "" if outside_value.blank?
    b_value = outside_value.to_i
    inside_value = inside_value.split(' ').first
    res = if ((inside_value.include? '+') && inside_value.chomp('+').to_i <= b_value)
            b_value
          elsif (inside_value.to_i == b_value)
            b_value
          elsif (inside_value.length == 2 and flag.present? and inside_value.to_i <= b_value)
            b_value
          elsif (inside_value.split('-')[0].to_i..inside_value.split('-')[1].to_i).include? b_value
            b_value
          else
            ''
          end
    res
  end

  GROUPING_POINTS_2015 = {'1' => {'C' => ['4+ C', '2-3 B', '0-1 A'], 'F' => ['16+ H', '15 G', '0-14 F'], 'S' => ['11-13 P', '10 N','7-9 M','6 L','0-5 K'], },
                          '2' => {'C' => ['8+ C', '2-7 B', '0-1 A'], 'F' => ['14+ H', '4-13 G', '0-3 F'], 'S' => ['N/A','N/A','18-19 M','16-17 L','14-15 K']},
                          '3' => {'C' => ['2+ C', '1 B', '0 A'], 'F' => ['11+ H', '10 G', '0-9 F'], 'S' => ['11-13 P', '10 N','7-9 M','6 L','0-5 K']},
                          '4' => {'C' => ['13+ C', '6-12 B', '0-5 A'], 'F' => ['8+ H', '1-7 G', '0 F'], 'S' => ['N/A','N/A','18-19 M','16-17 L','14-15 K']},
                          '5' => {'C' => ['17+ C', '4-16 B', '0-3 A'], 'F' => ['6+ H', '3-5 G', '0-2 F'], 'S' => ['N/A','N/A','N/A','N/A','20 K']}
  }
  GROUPING_POINTS_2014 = {'1' => {'C' => ['9+ C', '5-8 B', '0-4 A'], 'F' => ['7+ H', '6 G', '0-5 F'], 'S' => ['11-13 P', '10 N','7-9 M','6 L','0-5 K']},
                          '2' => {'C' => ['15+ C', '7-14 B', '0-6 A'], 'F' => ['8+ H', '7 G', '0-6 F'], 'S' => ['N/A','N/A','18-19 M','16-17 L','14-15 K']},
                          '3' => {'C' => ['6+ C', '3-5 B', '0-2 A'], 'F' => ['10+ H', '9 G', '0-8 F'], 'S' => ['11-13 P', '10 N','7-9 M','6 L','0-5 K']},
                          '4' => {'C' => ['17+ C', '9-16 B', '0-8 A'], 'F' => ['9+ H', '8 G', '0-7 F'], 'S' => ['N/A','N/A','18-19 M','16-17 L','14-15 K']},
                          '5' => {'C' => ['15+ C', '8-14 B', '0-7 A'], 'F' => ['8+ H', '7 G', '0-6 F'], 'S' => ['N/A','N/A','N/A','N/A','20 K']}
  }

end
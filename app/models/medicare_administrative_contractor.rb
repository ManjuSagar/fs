class MedicareAdministrativeContractor
  attr_accessor :agency, :mode
  PALMETTO_AGENCY_STATE_CODES = ['AL', 'AR', 'FL', 'GA', 'IL', 'IN', 'KY', 'LA', 'MS', 'NM', 'NC', 'OH', 'OK', 'SC', 'TN', 'TX']

  def initialize(agency, mode)
    @agency = agency
    @mode = mode
  end

  def batch_receive_list_service_id
    (mode == 'P' and is_palmetto_mac?) ? '278' : '352'
  end

  def batch_submit_service_id
    (mode == 'P' and is_palmetto_mac?) ? '277' : '351'
  end

  def receiver_id
    if is_palmetto_mac?
      '11001' #For HH+H (Palmetto MAC)
    elsif ['WI', 'MN', 'MI', 'NY', 'NJ', 'PR', 'VI'].include? agency.state
      '06001'
    elsif ['AK', 'AS', 'AZ', 'CA', 'GU', 'HI', 'ID', 'MP', 'NV', 'OR', 'WA'].include? agency.state
      "06014"
    else
      raise "No receiver id for #{agency.to_s}- #{agency.state}"
    end
  end

  def is_palmetto_mac?
    PALMETTO_AGENCY_STATE_CODES.include? agency.state
  end

end
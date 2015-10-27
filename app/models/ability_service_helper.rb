module AbilityServiceHelper

  TEST_MODE = 'T'
  PRODUCTON_MODE = 'T'

  def send_post_request
    ability_service_klass = ms_ability_service_klass

    request_details = [url, x_seapi_version, host, user_agent, content_type, post_content]

    ms_ability_service = ability_service_klass.new(key_store_file, key_store_certificate_pwd, request_details, alias_name)

    ms_ability_service.sendPostRequest()
  end

  def send_get_request
    ability_service_klass = ms_ability_service_klass

    request_details = [get_url, x_seapi_version, host, user_agent, content_type, ""]

    ms_ability_service = ability_service_klass.new(key_store_file, key_store_certificate_pwd, request_details, alias_name)

    ms_ability_service.getInformation()
  end

  def send_get_request_for_edi(url)
    ability_service_klass = ms_ability_service_klass

    request_details = [url, x_seapi_version, host, user_agent, content_type, ""]

    ms_ability_service = ability_service_klass.new(key_store_file, key_store_certificate_pwd, request_details, alias_name)

    ms_ability_service.getInformation()

  end

  def ms_ability_service_klass
    Rjb::load(ENV['CLASS_PATH'], [ENV['JVM_ARGS']]) unless Rjb::loaded?
    Rjb::import('com.fasternotes.AbilityService')
  end

  def key_store_file
    submitter_id = @agency.health_agency_detail.submitter_id
    jks_file_name = submitter_id+'.jks'
    if jks_file_name.include? submitter_id
      file = File.join(ENV['HOME'], jks_file_name)
      file = ((File.exists? file) ? file : "/workspace/certificates/#{jks_file_name}")
    else
      file = File.join(ENV['HOME'], 'ability_keystore.jks')
      file = ((File.exists? file) ? file : "/workspace/certificates/ability_keystore.jks")
    end
  end

  def key_store_certificate_pwd
    @source_password.present? ? @source_password : "b&3g9z$j"
  end

  def alias_name
    @alias_name.present? ? @alias_name : "cn=larry.treystman@001"
  end

  def host
    if @mode == self.class::TEST_MODE
      "seapitest.visionshareinc.com:443"
    else
      "portal.visionshareinc.com:443"
    end
  end

  def x_seapi_version
    "1"
  end

  def user_agent
    "Jim's Practice Management System/2.3"
  end

  def content_type
    "application/EDI-X12"
  end

  def post_content
    "ISA*00*          *00*          *ZZ*352316686      *ZZ*RECEIVER ID    *141024*1318*^*00501*000000111*1*T*:~GS*HC*352316686*RECEIVER ID*20141024*1318*1*X*005010X223A2~ST*837*1234*005010X223A2~BHT*0019*00*000000033300000003330000000333*20141024*1318*CH~NM1*41*2*Metropolitan Healthcare, Inc.*****46*1942484381~PER*IC*Mariam Zakharyan*EM*info@mymetrohc.com*TE*(323) 960-2533~NM1*40*2*CMS*****46*RECEIVER ID~HL*1**20*1~PRV*BI*PXC*251E00000X~NM1*85*2*Metropolitan Healthcare, Inc.*****XX*1942484381~N3*4929 Wilshire Blvd.~N4*Los Angeles*CA*90010~REF*EI*352316686~PER*IC*Mariam Zakharyan*EM*info@mymetrohc.com*TE*(323) 960-2533~HL*2*1*22*0~SBR*P*18*******MB~NM1*IL*1*Klochikhina*Valentina****MI*624458167M~N3*1637 Vine St.*SUITE 608~N4*Los Angeles*CA*90028~DMG*D8*19351010*F~REF*SY*624458167~NM1*PR*2*MEDICARE*****PI*059253~N3*STREET ADRRESS~N4*CITY*CA*ZIPCODE~CLM*73   295*3884.14***03:A:2**A*Y*Y~DTP*434*RD8*20140108-20140108~DTP*435*DT*2014010800~CL1**1*30~REF*G1*14AH14AH11IFKGBIKH~HI*ABK:71696~HI*BE:61:::31084~HI*BF:4019*BF:311*BF:3659*BF:3310*BF:53081*BF:78052*BF:2724~NM1*71*1*Baltaian*Lilit****XX*1154552305~LX*1~SV2*023*HC:1CGMS*3884.14*UN*0~DTP*472*D8*20140108~SE*35*1234~GE*1*1~IEA*1*000000111~"
  end

end
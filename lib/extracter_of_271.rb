require "stupidedi"
require 'csv'
require 'hb_271_definition'

class ExtracterOf271

  def initialize edi_271, hcpc_codes_file_path = "hcpc_2013.csv"
    @hcpc_codes_file_path = hcpc_codes_file_path
    fixed_edi_271 = fix_nm1_to_cover_for_stupid_edi_limitation edi_271
    parser = Stupidedi::Builder::StateMachine.build(make_config)
    @parser, @result = parser.read(Stupidedi::Reader.build(fixed_edi_271))
    @edi_content = fixed_edi_271
    @parser.zipper.map{|z| 
    }.explain { 
      puts "Non-deterministic state" 
      raise "EDI 271 string is in Non-deterministic state. Possible formatting issue/bug on the other side"
    }
    
    prepare_codes
  end
  
  # LIMITATIONS OF PARSING CODE
  # For convenience we are looking at only descriptions.
  # In the future descriptions may change for a particular code  
  def extract
    machine = @parser
    isa = nil
    machine.first.flatmap do |isa_l| 
      isa = isa_l
      break
    end
    
    data_hash = {}

    # First CHECK to Make sure we have received a valid response
    isa.iterate(:GS) do |gs|      
      gs.iterate(:ST) do |st|
        st.iterate(:HL) do |hl|
          if hl.element(1).map(&:node).map(&:value).fetch(nil) == '3' # 3 = Patient Type User
            aaa = hl.find(:NM1).fetch(nil).find(:AAA).fetch(nil)
            debug_log aaa.inspect
            if aaa
              Rails.logger.error "EDI Failure Text Below: \n #{@edi_content}"
              return {}
            end
          end
        end
      end
    end

    eb_counter = 1
    isa.iterate(:GS) do |gs|      
      gs.iterate(:ST) do |st|
        st.iterate(:HL) do |hl|
          if hl.element(1).map(&:node).map(&:value).fetch(nil) == '3' # 3 = Patient Type User
            insured = {}
            el(hl.find(:NM1), 1){|e| insured[:party_type] = e }
            el(hl.find(:NM1), 2){|e| insured[:party_individual] = e }
            el(hl.find(:NM1), 3){|e| insured[:party_last_name] = e }
            el(hl.find(:NM1), 4){|e| insured[:party_first_name] = e }
            el(hl.find(:NM1), 5){|e| insured[:party_middle_name] = e }
            el(hl.find(:NM1), 6){|e| insured[:party_prefix_name] = e }
            el(hl.find(:NM1), 7){|e| insured[:party_suffix_name] = e }
            el(hl.find(:NM1), 8){|e| insured[:party_id_type] = e }
            el(hl.find(:NM1), 9){|e| insured[:party_id_value] = e }
        
            n3 = hl.find(:NM1).fetch(nil).find(:N3)

            el(n3, 1){|e| insured[:party_address_line_1] = e }
            el(n3, 2){|e| insured[:party_suite] = e }

            n4 = n3.fetch(nil).find(:N4)

            el(n4, 1){|e| insured[:party_city] = e }
            el(n4, 2){|e| insured[:party_state] = e }
            el(n4, 3){|e| insured[:party_zip] = e }

            dmg = n3.fetch(nil).find(:DMG)

            el(dmg, 2){|e| insured[:party_date] = e }
            el(dmg, 3){|e| insured[:party_gender] = e }
            el(dmg, 4){|e| insured[:party_marital_status] = e }
        
            data_hash[:insured] = insured
          end
      
          hl.find(:NM1).fetch(nil).iterate(:EB) do |eb|
            eligibility = {}
            el(eb, 1){|e| eligibility[:eb_code] = e }
            el(eb, 2){|e| eligibility[:coverage_level_code] = e }
            el(eb, 3){|e| eligibility[:service_type_code] = e }
            el(eb, 4){|e| eligibility[:insurance_type_code] = e }
            el(eb, 5){|e| eligibility[:plan_coverage_description] = e }
            el(eb, 6){|e| eligibility[:time_period_qualifier] = e }
            el(eb, 7){|e| eligibility[:monetary_amount] = e.to_f }
            el(eb, 8){|e| eligibility[:percent_as_decimal] = e }
            el(eb, 9){|e| eligibility[:quantity_qualifier] = e }
            el(eb, 10){|e| eligibility[:quantity] = e.to_f }
            el(eb, 11){|e| eligibility[:authorization_indicator] = e }
            el(eb, 12){|e| eligibility[:in_plan_network_indicator] = e }
            el(eb, 13){|e|
              #Special Processing for procedure codes
              code = e.split('|')[1]
              value = e
              value = @hcpc_codes[code] if @hcpc_codes[code] 
              eligibility[:medical_procedure_identifier] = value 
            }
            if true 
    #          pp eb.successors
            end

            dtp_counter = 1
            eb.iterate(:DTP) do |dtp|
              el(dtp, 1){|e| 
                value = e
                value = cms_label( eligibility[:service_type_code], value)  
                eligibility[:"date_time_period_qualifier_#{dtp_counter}"] = value 
              }
              el(dtp, 3){|e| eligibility[:"date_time_period_#{dtp_counter}"] = e }
              dtp_counter = dtp_counter + 1
            end

            ref = eb.find(:REF)
            el(ref, 1){|e| eligibility[:reference_id_qualifier] = e }
            el(ref, 2){|e| eligibility[:reference_id] = e }
            el(ref, 3){|e| eligibility[:reference_description] = e }

            msg = eb.find(:MSG)
            el(msg, 1){|e| eligibility[:message] = e }
        
            ls = eb.find(:LS).fetch(nil)
            if ls
              related_parties_counter = 1
              ls.iterate(:N1G) do |nm1|
                eligibility[:related_parties] = {} if eligibility[:related_parties].nil?
                related = {}
                el(nm1, 1){|e| related[:party_type] = e }
                el(nm1, 2){|e| related[:party_individual] = e }
                el(nm1, 3){|e| related[:party_last_name] = e }
                el(nm1, 4){|e| related[:party_first_name] = e }
                el(nm1, 5){|e| related[:party_middle_name] = e }
                el(nm1, 6){|e| related[:party_prefix_name] = e }
                el(nm1, 7){|e| related[:party_suffix_name] = e }
                el(nm1, 8){|e| 
                  value = e
                  value = "CMS NPI" if value == 'CodeList.external(537)'
                  related[:party_id_type] = value
                }
                el(nm1, 9){|e| 
                  related[:party_id_value] = e
                }
                eligibility[:related_parties][:"related_party_#{related_parties_counter}"] = related
                related_parties_counter += 1
              end
            end

            if eligibility.blank? == false
              data_hash[:"eligibility_or_benefit_#{eb_counter}"] = eligibility
              eb_counter = eb_counter + 1
            end
          end
        end
      end
    end    
    data_hash
  end
  
  private
  
  def prepare_codes
    hcpc_codes_temp = CSV.read(@hcpc_codes_file_path)
    @hcpc_codes = {}
    hcpc_codes_temp.each {|r|
      @hcpc_codes[r[0]] = r[1]
    }
  end
  
  def cms_label service_type_code, id_name
    label_map = {
      'Home Health Care' => {
        'Service' => 'Episode Period Start & End Dates',
        'Period Start' => 'Episode Date of Earliest Billing Action',
        'Period End' => 'Episode Date of Latest Billing Action'
      }
    }
    if label_map[service_type_code] && label_map[service_type_code][id_name]
      label_map[service_type_code][id_name]
    else  
      id_name
    end
  end  
  
  #Special processing to convert IDs to codes
  def el(m, *ns, &block)
    if Stupidedi::Either === m
      m.tap{|m| el(m, *ns, &block) }
    else
      yield(*ns.map{|n|
        value = m.element(*n).map(&:node).map(&:value).fetch(nil) rescue nil  #FIXME Hack. Need to check for class.
        if  m.element(*n).map(&:node).fetch(nil).class == Stupidedi::Versions::FunctionalGroups::FiftyTen::ElementTypes::IdentifierVal::NonEmpty
          t = m.element(*n).map(&:node).fetch(nil).inspect
          t[ /\(\w+:\s(.*)\)/ ];$1
          if $1
            $1
          else
            value
          end
        else
          value 
        end
      })
    end
  end
  
  
  def make_config
    config = Stupidedi::Config.new
    config.interchange.tap do |c|
      c.register("00501") { Stupidedi::Versions::Interchanges::FiveOhOne::InterchangeDef }
    end

    config.functional_group.tap do |c|
      c.register("005010") { Stupidedi::Versions::FunctionalGroups::FiftyTen::FunctionalGroupDef }
    end

    config.transaction_set.tap do |c|
      c.register("005010X279A1", "HB", "271") { GuruKrupa::HB271 }
      c.register("005010X279", "HB", "271") { GuruKrupa::HB271 }
    end  
    config  
  end
  

  #Hack to fix the stupidEDI's parsing limitation for NM1. Long story
  def fix_nm1_to_cover_for_stupid_edi_limitation edi_271
    string_io = StringIO.new(edi_271) 
    file_content = string_io.readlines
    in_ls_loop = false
    file_content.each {|l|
      if l =~ /^LS*/
        in_ls_loop = true
      elsif l =~ /^LE*/
        in_ls_loop = false
      elsif l =~ /^NM1\*/ && in_ls_loop
        l.gsub!(/^NM1\*/, 'N1G*')
      end
    }
    file_content.join
  end
  
end
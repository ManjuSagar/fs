require 'jasper-rails'
require 'tempfile'

class BilledClaimsReportDataSource
  include BilledReportBasedMethods
  include JasperRails

  CLAIM_TYPE_SORT = {"R" => 1, "F" => 2, "L" => 3}

  def initialize params
    collect_billed_claims params
  end

  def collect_billed_claims(params)
    @filter_by = params[:filter_value]
    @from_date = Date.parse(params[:from_date], "%m/%d/%Y") if params[:from_date]
    @to_date = Date.parse(params[:to_date], "%m/%d/%Y") if params[:to_date]
    @group_by = params[:group_by_value].blank? ? 'all' : params[:group_by_value]
    @payload = display_billed_claims
  end

  def empty?
    @payload.empty?
  end

  def display_billed_claims
    billed_claims = []
    all_invoices = Invoice.org_scope
    filtered_invoices = all_invoices
    filtered_invoices = filtered_invoices.where(["sent_date is not null and invoice_type IN (?)",['322', '329', '327']])
    case @filter_by
      when "SD"
        filtered_invoices = filtered_invoices.where(["sent_date between ? and ?", @from_date, @to_date])
      when "ERD"
        #Superficial filter. Further filter inside the loop
          filtered_invoices = filtered_invoices.where(["sent_date between ? and ?", @from_date + 7, @to_date + 15])
      else
        raise "Unknown Filter by Option (#{@filter_by}) in Billed Claims Report DataSource"
    end
    filtered_invoices.all.each do |invoice|
      if @filter_by == 'ERD'
        next if (invoice.expected_date_display < @from_date || invoice.expected_date_display > @to_date)
      end
      patient_name_and_mr_number = invoice.patient_full_name_with_mr_number
      soc_date = invoice.soc_date_formatted
      total_amount = invoice.total_amount
      episode_certification_period = invoice.treatment_episode.certification_period_mmddyyyy
      claim_type = Invoice::INVOICE_TYPES[invoice.invoice_type][0]
      invoice_sent_date = invoice.sent_date_formatted
      expected_date = invoice.expected_date_display.strftime("%m/%d/%y")
      expected_amount = invoice.expected_amount
      claim_type_desc = case invoice.invoice_type
        when '322'
          'RAP'
        when '329'
          'Final Claim'
        when '327'
          'LUPA'
        else
          raise "unkonwn invoice type #{invoice.invoice_type}"
      end
      billed_claims << {patient_name_and_mr_number: patient_name_and_mr_number, soc_date: soc_date,
                        episode: episode_certification_period, claim_type: claim_type, claim_type_desc: claim_type_desc,
                        sent_date: invoice_sent_date, expected_date: expected_date, total_amount: total_amount,
                        expected_amount: expected_amount, claim_type_sort: CLAIM_TYPE_SORT[claim_type]}
    end
    if @group_by == 'C'
      billed_claims.sort_by! { |invoice| invoice[:claim_type_sort] }
    elsif @group_by == "E"
      billed_claims.sort_by! { |invoice| invoice[:expected_date] }
    else
      billed_claims.sort_by! { |invoice| invoice[:sent_date] }
    end
    billed_claims
  end

end
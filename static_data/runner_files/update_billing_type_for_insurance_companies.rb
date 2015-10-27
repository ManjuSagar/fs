ins = InsuranceCompany.where(company_code: 'MEDICARE')
ins.update_all(billing_flow: 'H')

private_ins = InsuranceCompany.where("company_code <> 'MEDICARE'")
private_ins.update_all(billing_flow: 'V')

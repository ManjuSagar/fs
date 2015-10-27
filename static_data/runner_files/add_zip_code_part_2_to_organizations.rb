org_name_with_zip_codes = [{org_name: 'Committed Home Health', zip_code: '48075-3132'},
                          {org_name: 'Gentlecare Home Health', zip_code: '75093-5438'},
                          {org_name: 'Hunt Country Health Services', zip_code: '22601-4144'},
                          {org_name: 'Infinity Home Healthcare, LLC.', zip_code: '87109-2323'},
                          {org_name: 'Luna Vista Home Healthcare', zip_code: '87114-5888'},
                          {org_name: 'Noho Home Health', zip_code: '91606-1140'},
                          {org_name: 'Noyan Home Healthcare, Inc.', zip_code: '91205-4912'},
                          {org_name: 'Omega Home Care Systems, Inc.', zip_code: '02368-5223'},
                          {org_name: 'VA Care Services, Inc.', zip_code: '77489-3548'},
                          {org_name: 'Barnes Home Health Care', zip_code: '45804-3302'},
                          {org_name: 'Healthy Heart Home Care',zip_code: '90249-4120'}
                          ]

org_name_with_zip_codes.each do |org_name_with_zip_code|
  zip_code = org_name_with_zip_code[:zip_code].split('-')
  org = Org.find_by_zip_code(zip_code[0])
  next if org.blank?
  org.update_column(:zip_code_part2, zip_code[1])
end
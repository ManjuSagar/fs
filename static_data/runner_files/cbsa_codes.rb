zip_county_names = ["Aleutians East", "Aleutians West (CA)", "Anchorage Municipality",
                    "Baltimore (city)", "Bedford (city)", "Bethel (CA)", "Bristol (city)", "Buena Vista (city)",
                    "Carson City (city)", "Charlottesville (city)", "Chesapeake (city)","Colonial Heights (city",
                    "Covington (city)", "Danville (city)",
                    "DeBaca", "DeKalb", "DeSoto",
                    "Doña Ana", "DuPage", "Emporia (city)", "Fairbanks North Star", "Fairfax (city)",
                    "Falls Church (city)", "Fond du Lac", "Franklin (city)", "Fredericksburg (city)",
                    "Galax (city)", "Hampton (city)", "Harrisonburg (city)", "Hopewell (city)", "Indian River",
                    "Isle of Wight", "James City", "Kenai Peninsula", "Ketchikan Gateway",
                    "King and Queen", "Kodiak Island", "LaGrange", "LaPorte", "Lac qui Parle", "Lake and Peninsula",
                    "Lake of the Woods", "Lewis and Clark", "Lynchburg (city)", "Manassas (city)",
                    "Manassas Park (city)", "Martinsville (city)", "Matanuska", "McCone", "McCracken", "McCreary",
                    "McCulloch", "McCurtain", "McDonald", "McDonough", "McDuffie", "McKean", "McKinley",
                    "McLeod", "McMinn", "McMullen", "McNairy", "McPherson", "Newport News (city)",
                    "Nome (CA)", "Norfolk (city)", "North Slope", "Northwest Arctic",
                    "Norton (city)", "O'Brien", "Petersburg (city)", "Poquoson (city)", "Portsmouth (city)",
                    "Prince of Wales", "Queen Anne's", "Radford (city)",
                    "Red Willow", "Richmond (city)", "Roanoke (city)", "Saint Clair",
                    "Salem (city)", "Sitka City and Borough", "Skagway",
                    "Southeast Fairbanks (C", "St. Francis", "St. Francois", "St. Helena", "St. James", "St. John the Baptist",
                    "St. Landry", "St. Lawrence", "St. Louis (city)", "St. Martin", "St. Mary", "St. Mary's", "Staunton (city)",
                    "Ste. Genevieve", "Suffolk (city)", "Valdez", "Virginia Beach (city)", "Wade Hampton (CA)",
                    "Waynesboro (city)", "Williamsburg (city)", "Winchester (city)", "Wrangell", "Yukon"]

cbsa_county_names = ["Aleutians County East", "Aleutians County West", "Anchorage",
                     "Baltimore City", "Bedford City", "Bethel", "Bristol City", "Buena Vista City",
                     "Carson City","Charlottesville City", "Chesapeake City", "Colonial Heights",
                     "Covington City", "Danville City","De Baca", "De Kalb", "Desoto",
                     "Dona Ana", "Du Page", "Emporia", "Fairbanks", "Fairfax City",
                     "Falls Church City", "Fond Du Lac", "Franklin City","Fredericksburg City",
                     "Galax City", "Hampton City", "Harrisonburg City", "Hopewell City", "Indian River County",
                     "Isle Of Wight", "James City Co", "Kenai Peninsula Borough", "Ketchikan",
                     "King And Queen", "Kodiak", "Lagrange", "La Porte", "Lac Qui Parle", "Lake and Peninsula Borough",
                     "Lake Of Woods", "Lewis And Clark", "Lynchburg City", "Manassas City",
                     "Manassas Park City", "Martinsville City", "Matanuska", "Mc Cone", "Mc Cracken", "Mc Creary",
                     "Mc Culloch", "Mc Curtain", "Mc Donald", "Mc Donough", "Mc Duffie", "Mc Kean", "Mc Kinley",
                     "Mc Leod", "Mc Minn", "Mc Mullen", "Mc Nairy", "Mc Pherson", "Newport News City", "Nome",
                     "Norfolk City", "North Slope Borough", "Northwest Arctic Borough", "Norton City",
                     "O Brien", "Petersburg City", "Poquoson City", "Portsmouth City",
                     "Prince of Wales", "Queen Annes", "Radford City", "Redwillow", "Richmond City",
                     "Roanoke City", 'St Clair', "Salem City", "Sitka", "Skagway",
                     "Southeast Fairbanks", "St Francis", "St Francois", "St Helena", "St James", "St. John Baptist",
                     "St Landry", "St Lawrence","St. Louis City", "St Martin", "St Mary", "St Marys",
                      "Staunton City", "Ste Genevieve", "Suffolk City",
                     "Valdz", "Virginia Beach City","Wade Hampton", "Waynesboro City",
                     "Williamsburg City", "Winchester City", "Wrangell", "Yukon"]

zip_states = ["West Virginia", "District of Columbia", "South Carolina", "North Carolina", "South Dakota", "North Dakota"]
cbsa_states = ["W Virginia", "Dist of Col", "S Carolina", "N Carolina", "S Dakota", "N Dakota"]

zip_county_names.each_with_index { |county_name, index|
  zip_codes = ZipCode.where(admin_name_2: county_name)
  zip_codes.update_all(admin_name_2: cbsa_county_names[index])
}

cbsa_states.each_with_index {|state, index|
  cbsa_codes = ProspectivePaymentSystem::MedicareCoreStatArea.where({state_name: state})
  cbsa_codes.update_all(state_name: zip_states[index])
}

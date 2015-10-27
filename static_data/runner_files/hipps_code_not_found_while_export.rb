docs = Document.where(["id in (?)", [945, 637, 816, 819, 978, 983, 985, 980, 982]])

docs.each do |document|
  document.generate_hipps_code
end
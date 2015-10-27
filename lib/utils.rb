def js_hash_to_ruby_hash(hsh)
  hsh.inject({}){|r, h|
    val = h[1].is_a?(Hash) ? js_hash_to_ruby_hash(h[1]) : h[1]
    r[h[0].underscore.to_sym] = val
    r
  }
end

def tempfile
  File.join(Rails.root, "tmp", "#{Time.now.to_f}-#{rand(1000000)}".gsub('.','-'))
end

def combined_pdf_files(files)
  combined_pdf_file = "#{tempfile}.pdf"
  require 'pdf_merger'
  PdfMerger.new.merge(files, combined_pdf_file)
  combined_pdf_file
end
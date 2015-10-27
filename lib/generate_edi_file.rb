require "stupidedi"

class GenerateEdiFile

# You can customize this to delegate to your own grammar definitions, if needed.
  config = Stupidedi::Config.default

  b = Stupidedi::Builder::BuilderDsl.build(config)

# These methods perform error checking: number of elements, element types, min/max
# length requirements, conditionally required elements, valid segments, number of
# segment occurrences, number of loop occurrences, etc.
  b.ISA "00", nil, "00", nil,
        "ZZ", "SUBMITTER ID",
        "ZZ", "RECEIVER ID",
        "990531", "1230", nil, "00501", "123456789", "1", "T", nil

# The API tracks the current position in the specification (e.g., the current loop,
# table, etc) to ensure well-formedness as each segment is generated.
  b.GS "HC", "SENDER ID", "RECEIVER ID", "19990531", "1230", "1", "X", "005010X222"

# The `b.default` value can be used to generate the appropriate value if it can
# be unambigously inferred from the grammar.
  b.ST "837", "1234", b.default
# You can use string representations of data or standard Ruby data types, like Time.
  b.BHT "0019", "00", "X"*30, "19990531", Time.now.utc, "CH"
  b.NM1 b.default, "1", "PREMIER BILLING SERVICE", nil, nil, nil, nil, "46", "12EEER000TY"
  b.PER "IC", "JERRY THE CLOWN", "TE", "3056660000"

  b.NM1 "40", "2", "REPRICER JONES", nil, nil, nil, nil, "46", "66783JJT"
  b.HL "1", nil, "20", "1"

  b.NM1 "85", "2", "PREMIER BILLING SERVICE", nil, nil, nil, nil, "XX", "123234560"
  b.N3  "1234 SEAWAY ST"
  b.N4  "MIAMI", "FL", "331111234"
  b.REF "EI", "123667894"
  b.PER "IC", b.blank, "TE", "3056661111"

  b.NM1 "87", "2"
  b.N3 "2345 OCEAN BLVD"
  b.N4 "MIAMI", "FL", "33111"

  b.HL "2", "1", "22", "0"
  b.SBR "S", "18", nil, nil, "12", nil, nil, nil, "MB"

  b.NM1 "IL", "1", "Doe", "Jhon", "T", nil, "JR", "MI", "222334444"
  b.N3  "236 N MAIN ST"
  b.N4  "MIAMI", "FL", "33413", "767"
  b.DMG "D8", "19431022", "F"

  b.CLM "A37YH556", "500", nil, nil, "11", nil, nil, "Y", "Y"  #Patient Control Number, Total Charges,,,,,,Response Code, Release of Information Code
  b.DTP "435", "DT", "199701150000"

  b.machine.zipper.tap do |z|
    # The :component, and :repetition parameters can also be specified as elements
    # of the ISA segment, at `b.ISA(...)` above. When generating a document from
    # scratch, :segment and :element must be specified -- if you've parsed the doc
    # from a file, these params will default to whatever was used in the file, or
    # you can override them here.
    separators =
        Stupidedi::Reader::Separators.build :segment    => "~\n",
                                            :element    => "*",
                                            :component  => ":",
                                            :repetition => "^"

    # You can also serialize any subtree within the document (e.g., everything inside
    # some ST..SE transaction set, or a single loop. Here, z.root is the entire tree.
    w = Stupidedi::Writer::Default.new(z.root, separators)
    w.write($stdout)
  end
end
desc "Electronic claims transmission"
task :electronic_claims_transmission => [:environment] do
  clm_transmitter = ClaimTransmitter.new
  clm_transmitter.run
  trn_processor = TrnProcessor.new
  trn_processor.run
  ta1_processor = Ta1Processor.new
  ta1_processor.run
  processor_999 = Processor999.new
  processor_999.run
  processor_277ca = Processor277Ca.new
  processor_277ca.run
end


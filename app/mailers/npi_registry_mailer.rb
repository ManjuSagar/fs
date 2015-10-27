class NpiRegistryMailer < ActionMailer::Base
  default from: "fnpublic@gmail.com"

def send_npi_registry_import_notification(msg)
  puts "Sending NPI registry Import Notification"
  @msg = msg
  mail(to: "fnnotification@gmail.com", subject: "FasterNotes: NPI Registery Import Notification")
end

  def send_pecos_flag_update(msg)
    puts "Sending PECOS flag updation Notification"
    @msg = msg
    mail(to: "fnnotification@gmail.com", subject: "FasterNotes: PECOS flag updation for physician")
  end
end

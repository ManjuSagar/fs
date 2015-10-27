# Load the rails application
require File.expand_path('../application', __FILE__)
unless ENV['JAVA_HOME']
  if "#{Rails.root}".include?("msuser1") #In local system: production mode running java home settings.
    ENV['JAVA_HOME']="/home/msuser1/workspace/jdk1.6.0_43/"
    ENV['LD_LIBRARY_PATH']="#{ENV['LD_LIBRARY_PATH']}:#{ENV['JAVA_HOME']}/jre/lib/i386:#{ENV['JAVA_HOME']}/jre/lib/i386/client"
  else
    ENV['JAVA_HOME']= (File.exists? "/usr/lib/jvm/jdk1.7.0_09") ? "/usr/lib/jvm/jdk1.7.0_09" : "/usr/lib/jvm/java-1.7.0-openjdk-amd64/"
    ENV['LD_LIBRARY_PATH']="#{ENV['JAVA_HOME']}/jre/lib/amd64"
  end
end
# Initialize the rails application
FasterNotes::Application.initialize!
SmartSession::Store.session_class = :postgres

Spawn::default_options :method => :thread, :nice => 7
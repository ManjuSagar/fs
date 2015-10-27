require 'term/ansicolor'

# yeilds a stacktrace for each SQL query
# put this file in config/initializers
class QueryTrace < ActiveSupport::LogSubscriber
  include Term::ANSIColor
  attr_accessor :trace_queries

  def sql(event)  #:nodoc:
    return unless QueryTrace.enabled? && logger.debug? && Rails.env.development?
    payload = event.payload
    sql = payload[:sql].squeeze(' ')    
    looking_for = %Q[]
    looking_for = %Q[SELECT "patient_treatments".* FROM "patient_treatments" WHERE "patient_treatments"."id" =]
    looking_for = %Q[SELECT "treatment_visits".* FROM "treatment_visits" WHERE "treatment_visits"."treatment_id" = 48 ORDER BY id LIMIT 30 OFFSET 0]
    looking_for = %Q[SELECT "treatment_visits".* FROM "treatment_visits" WHERE "treatment_visits"."treatment_id" IS NULL ORDER BY id LIMIT 30 OFFSET 0]
    return unless sql.include? looking_for
    #return unless (payload[:binds] && [39, 40].include?(payload[:binds][0][1]) ) 
    #stack = Rails.backtrace_cleaner.clean(caller)
    stack = caller.dup
    first_line = stack.shift
    return unless first_line
#    first_line += "ID = #{payload[:binds][0][1]}, " + first_line
    msg = prefix + bold + cyan + "#{first_line}\n" + reset
    msg += cyan + stack.join("\n") + reset
    debug msg
  end

  # :call-seq:
  # Klass.enabled?
  #
  # yields boolean if SQL queries should be logged or not

  def self.enabled?
    defined?(@trace_queries) && @trace_queries
  end

  # :call-seq:
  # Klass.status
  #
  # yields text if QueryTrace has been enabled or not

  def self.status
    QueryTrace.enabled? ? 'enabled' : 'disabled'
  end

  # :call-seq:
  # Klass.enable!
  #
  # turn on SQL query origin logging

  def self.enable!
    @trace_queries = true
  end

  # :call-seq:
  # Klass.disable!
  #
  # turn off SQL query origin logging

  def self.disable!
    @trace_queries = false
  end

  # :call-seq:
  # Klass.toggle!
  #
  # Toggles query tracing yielding a boolean indicating the new state of query
  # origin tracing

  def self.toggle!
    enabled? ? disable! : enable!
    enabled?
  end

protected

  def prefix  #:nodoc:
    bold(magenta('Called from: ')) + reset
  end
end

QueryTrace.attach_to :active_record

trap('QUIT') do
  # Sending 2 backspace characters removes the ^\ that is 
  # printed to the console.
  rm_noise = "\b\b"

  QueryTrace.toggle!
  puts "#{rm_noise}=> QueryTrace #{QueryTrace.status}"
end

QueryTrace.enable! if ENV['QUERY_TRACE']
puts "=> QueryTrace #{QueryTrace.status}; CTRL-\\ to toggle"

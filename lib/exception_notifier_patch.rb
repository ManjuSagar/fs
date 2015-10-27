require 'exception_notifier/notifier'
class ExceptionNotifier
  class Notifier < ActionMailer::Base

    alias_method :compose_subject_new, :compose_subject
    def compose_subject
      server_type = if @request.url.include?("staging")
                      "[STG] "
                    elsif @request.url.include?("apps")
                      "[PRD] "
                    else
                      "[LHT] "
                    end
      sub = compose_subject_new
      org_name = @request.url.include?("signin") ? "" : Org.current.to_s
      default_prefix_length = self.class.default_email_prefix.length
      res = self.class.default_email_prefix + server_type + ((org_name.length > 0) ? "[#{org_name[0..4]}] " : "") + sub[default_prefix_length..(sub.length-4)]
      res.length > 120 ? res[0...120] + "..." : res
    end
  end
end
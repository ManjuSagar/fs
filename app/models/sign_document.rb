module SignDocument
  def self.included(klass)
    attr_accessor :sign_password, :signature_date
    klass.validate :validate_sign_password

    def validate_sign_password
      if (sign_password and signature_date)
        errors.add(:sign_password, "Invalid Password") unless User.current.valid_sign_password?(sign_password)
      end
    end
    def set_comment_for_fs_signed
      self.audit_comment = "Sign(#{self.class} " + self.id.to_s + ")"
    end
  end
end
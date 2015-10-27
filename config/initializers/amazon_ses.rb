#ActionMailer::Base.add_delivery_method :ses, AWS::SES::Base,
#                                       :access_key_id     => 'AKIAIWDX35N76H3IMWFQ',
#                                       :secret_access_key => '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'


ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "gmail.com",
    :user_name            => " alert@fasternotes.com",
    :password             => "515253tt",
    :authentication       => "plain",
    :enable_starttls_auto => true
}
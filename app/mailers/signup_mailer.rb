class SignupMailer < ActionMailer::Base
  default from: "support@tagaly.com"
  def signup_email(email)
    @email = email
    mail(to: @email, subject: 'Thank You for Registering at Tagaly')
  end
end

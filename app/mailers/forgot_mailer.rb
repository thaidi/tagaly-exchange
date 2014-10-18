class ForgotMailer < ActionMailer::Base
  default from: "support@tagaly.com"
  def forgotpassword_email(email,ustring)
    @email = email
    @ustring=ustring
    mail(to: @email, subject: 'Tagaly - Reset password instructions')
  end
end

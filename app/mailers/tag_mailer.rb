class TagMailer < ActionMailer::Base
  default from: "support@tagaly.com"
  def tag_email(emails,code,sitename,email)
    @emails = emails
    @code=code
    #@url  = 'http://example.com/login'

  		mail(to: @emails, subject: email+' asked that we send you '+sitename+'s Tagaly tag!')
  end
    

end

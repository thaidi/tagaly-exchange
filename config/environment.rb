# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Tagaly3::Application.initialize!
ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  	:enable_starttls_auto => true,
    :address => "smtp.sendgrid.net",
    :port => 587,
    :domain => "tagaly.com",
    :authentication => :plain,
    :user_name => "app5446642@heroku.com",
    :password => "oktosw9p"
	}
	
	ActionMailer::Base.default :content_type => "text/html"
	ActionMailer::Base.perform_deliveries = true
	ActionMailer::Base.raise_delivery_errors = true

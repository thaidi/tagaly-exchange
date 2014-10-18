require File.expand_path('../boot', __FILE__)
require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Tagaly3

  LOCAL_HOST_API = "http://54.86.135.219:8080"
  MYAPPONE_API = "http://54.86.135.219:8080"
  MYAPPONE_TAG="http://54.86.135.219"
  AWS_TAG="http://54.86.135.219"
  AWS_API = "http://10.0.0.121:8080"
	AWS_ROR = "http://54.86.238.65:3000"
	MYAPPONE_ROR = "http://myappone.com:3000"
  HOST_NAME = Socket.gethostname
	RetargetCount = 10
	BannerSizes = "468x60,728x90,250x250,160x600,240x400,234x60,120x60,88x31,300x250,468x60,728x90,1024x90,120x20,168x28,216x36,300x250,300x50,220x50"
	BannerWeights = "30720,35840,35840,30720,35840,20480,20480,10240,40960,40960,40960,40960,40960,40960,40960,40960,40960,40960"
		if HOST_NAME == 'localhost.localdomain' || HOST_NAME == 'my.ppcminds.com'
  		SRC = MYAPPONE_API
  		TAG = MYAPPONE_TAG
			RORHOST = MYAPPONE_ROR
  	else
  		SRC = AWS_API
  		TAG=AWS_TAG
			RORHOST = AWS_ROR
  	end


  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
		# config.force_ssl = true
  end
end

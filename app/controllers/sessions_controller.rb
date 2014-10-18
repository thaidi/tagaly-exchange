=begin
  Session Management Controller
=end
class SessionsController < ApplicationController
skip_before_filter :verify_authenticity_token, :only => [:create]
  def new
		if session[:user_id]
			redirect_to "/"
		end
  end
  def create
    #### Login validation
	begin
    user = User.authenticate(params[:email], params[:password])
     rescue ActionController::InvalidAuthenticityToken
      redirect_to('/login')
      else
      @success =""
      end		
    if user
     #### Setting the sessions
			cookies[:user_name] = params[:email]
      session[:email]=params[:email]
      session[:user_timezone]=user.userTimezone
      session[:user_id] = user.id
      session[:user_name] = user.firstName
      session[:usertype] = user.userType
      session[:startdate] = Date.today - 6.days
      session[:enddate] = Date.today
      @site=Site.where(advertiserId: session[:user_id],siteStatus:"active").limit(1).order('id asc')
      @site.each do |sitei|
		    session[:site_name] = sitei.siteName
		    session[:site_id] = sitei.id
		    session[:site_url] = sitei.siteUrl
      end
      @Publishersites=Publishersite.where(created_by: session[:user_id] , status: 'Active').limit(1).order('id asc')
      @Publishersites.each do |psitei|
		    session[:publishersite_name] = psitei.website_title
		    session[:publishersite_id] = psitei.id
		    session[:publishersite_url] = psitei.website_url
			end
			if session[:redirectTo].present?
				redirectTo = session[:redirectTo]
				session[:redirectTo] = nil
      	redirect_to redirectTo
			else
      	redirect_to root_url
			end
    else
      flash[:error] = "Invalid email or password"
      render "new"
    end
  end
   #### logout starts here 
  def destroy
		session[:user_id] = nil
		session[:site_url]=nil
		session[:email]=nil
		session[:user_timezone]=nil
		session[:user_name] = nil
		session[:usertype] = nil
		session[:site_name] = nil
		session[:site_id] = nil
		session[:site_url] = nil
		session[:startdate] = nil
		session[:enddate] = nil
		session[:publishersite_name] = nil
		session[:publishersite_id] = nil
		session[:publishersite_url] = nil
		cookies.delete :user_name
		if params[:redirectTo].present?
			session[:redirectTo] = params[:redirectTo]
		end 
    redirect_to '/login', :notice => "Logged out!"
  end 
  #### Logout ends here 
  def index
	@sites =Site.where(advertiserId: session[:user_id],siteStatus:"active") if session[:user_id]
	if session[:user_id] == ''
		redirect_to '/login'
	else
		redirect_to root_url
	end
    
  end
end

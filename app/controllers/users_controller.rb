class UsersController < ApplicationController
def new
  @user = User.new
  @sites =Site.where(advertiserId: session[:user_id],siteStatus:"active") if session[:user_id]
end
def checkCookies
	if cookies[:user_name] == session[:user_id]
		render text: "success"
	else
		render text: "failed"
	end
end

def create
  if User.where('email = ?', params[:user][:email]).count == 0
  @user = User.new(params[:user])
  if @user.save
    SignupMailer.signup_email(params[:user][:email]).deliver
    flash[:notice] = "You have successfully signed up. Please Login here."
    redirect_to '/login'
  else
  	flash[:notice] = "Some error occured!Please try again"
    redirect_to '/login' 
  end
  else
  	flash[:notice] = "Email ID already exists! please Login!"
  	redirect_to '/login'
  end
end
def index
 @sites =Site.where(advertiserId: session[:user_id],siteStatus:"active") if session[:user_id]
end

### Action to check if the user already exists

def checkEmail
  if User.where('email = ?', params[:email]).count == 0
    render text: 0
  else
    render text: 1
  end
end

	def introduction
		# Redirects to login page if user is not logged in
		if !session[:user_id].present?
		  redirect_to '/login'
		
		else
		@sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
		render :layout => false
		end
	end
end

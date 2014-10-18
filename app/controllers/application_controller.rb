=begin
  main controller for the app
=end
class ApplicationController < ActionController::Base

	before_filter :set_cache_buster
	helper_method :render_404
	def render_404
		respond_to do |format|
		  format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
		  format.xml  { head :not_found }
		  format.any  { head :not_found }
		end
	end
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

 @RETARGETSEGMENT = ""
=begin  
  #### Error handling code starts here ####

   rescue_from(Errno::ECONNREFUSED) do |e|
    flash[:warning] = 'The server is down!'
    render :template => 'error/index'
   end
   rescue_from(Errno::ETIMEDOUT) do |e|
    flash[:warning] = 'Oops! Something went wrong!'
    render :template => 'error/index'
   end
   rescue_from(JSON::ParserError) do |e|
    flash[:warning] = 'Oops! Something went wrong!'
    render :template => 'error/index'
   end
   rescue_from(TypeError) do |e|
    flash[:warning] = 'Oops! Something went wrong!'
    render :template => 'error/index'
   end
   rescue_from(AbstractController::DoubleRenderError) do |e|
   
   end




   
   rescue_from(ActiveRecord::RecordNotFound) do |e|
    flash[:warning] = "Data not found for the request. Please <a href='#{log_out_path}' >logout</a> and try again.".html_safe
    render :template => 'error/index' 
   end

   

	
=begin	
  rescue_from(NoMethodError) do |e|
    flash[:warning] = 'Data Not Found!'
    render :template => 'error/index' ,:layout=>false
   end

		if session[:user_id].present?
		else
	    redirect_to '/login'
	  end
=end   
   #### Error handling code ends here ####
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    helper_method :current_user

   private
   def current_user
   	begin
   		if session[:user_id] && User.where(:id => session[:user_id]).blank?
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
		flash[:notice]="User details not found! Please contact the administrator!"
   			#render text: "<div align='center'><h>User details not found! Please contact the administrator!</h></div>".html_safe
   		else
   		
     		@current_user ||= User.find(session[:user_id]) if session[:user_id]
     	end
     
    end 
   end
   def user_is_logged_in?
    !!session[:user_id]
  end
end

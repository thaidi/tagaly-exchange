=begin
  # This controller is user to create, edit/update, view styles.
  # 
=end

class StylesController < ApplicationController

  layout 'createpublisher' 
  require 'net/http' 
  require 'json'
  require 'uri' 
	include CheckSiteIdHelper
  def new
		if session[:user_id] == '' || session[:user_id] == nil
			redirect_to '/login'
		else
		  @sites=Publishersite.where(created_by: session[:user_id] , status: 'Active')
			@fonts = Font.where(publisherid: session[:user_id])
		  @style = Style.new
			src =  Tagaly3::SRC
		  if params[:style]
		    params[:style][:userid] = session[:user_id]
		    params[:style][:styleName] = Rack::Utils.unescape(params[:style][:styleName])
		    # Form action is self. So, this lines will execute when form is submitted. 
		    # Code for inserting new style through API. 
		    @uri = URI.parse(src)
		    http = Net::HTTP.new(@uri.host,@uri.port)
		    request = Net::HTTP::Put.new("/adexchange/publisher/style")
					request.set_form_data({"name" => params[:style][:styleName], "border" => params[:style][:BorderColor] ,"title" => params[:style][:TitleColor],
					"text"=> params[:style][:TextColor], "url"=>params[:style][:urlColor], "fontSize"=> params[:style][:fontsize] ,"userId"=> params[:style][:userid],
					"cornerStyle"=> params[:style][:cornerstyle], "fontFamily"=> params[:style][:fontfamily], "background"=>params[:style][:BackgroundColor] ,
					"styleType"=> params[:style][:styletype] })
		    # 'response' holds Json data for the request sent to create style.
		    response = http.request(request)
		    # 'code' holds response code value.
				idval = ""
		    code = response.code
				idval = response.body
		    if code == '200'
		      flash[:notice] = "You have Added a style."
					if params[:style][:redirect].present?
						redirect_to params[:style][:redirect]
					else
				    if params[:style][:frame] == "frame"
				      redirect_to "/styles/?id=#{idval}&adType=#{params[:style][:styletype]}"
				    else
							if params[:adType] == "nativeAd"
								redirect_to "/adunits/creatingadunits?adType=nativeAd"
							else
								redirect_to "/styles/"
							end
				    end
					end
		    else
		      flash[:notice] = "Some error occured!Please try again"
		      redirect_to '/styles/new'
		    end
			else
	#=begin
			  userId = session[:user_id]
		    @uri = URI.parse(src)
		    http = Net::HTTP.new(@uri.host,@uri.port)
		    request = Net::HTTP::Get.new("/adexchange/publisher/style/list/#{userId}")
				response = http.request(request)
				@allstyles = JSON.parse(response.body)
	#=end
				if params[:frame] == "frame"
					render 'new' , :layout => false
				end
		  end
		end
	end
  # Code to display all the styles.
  def index
		if session[:user_id] == '' || session[:user_id] == nil
		  redirect_to '/login'
		else
			src =  Tagaly3::SRC
		  @sites=Publishersite.where(created_by: session[:user_id] , status: 'Active')
		  userId = session[:user_id]
		  #Code to connect to API
		  @uri = URI.parse(src)
		  http = Net::HTTP.start(@uri.host,@uri.port)
		  request = Net::HTTP::Get.new("/adexchange/publisher/style/list/#{userId}")
		  response = http.request(request)
		  @parsed = JSON.parse(response.body)
			http.finish
		end
    # '@parsed' holds the data for the request we sent to get the styles that were created by current user.
  end

  # Code to edit each style by its 'id'.
  def edit
    # Check whether form is submitted or not.
    # If form is submitted.
		if session[:user_id] == '' || session[:user_id] == nil
		  redirect_to '/login'
		else
			src =  Tagaly3::SRC
			@fonts = Font.where(publisherid: session[:user_id])
		  if params[:style]
		    @id = id = params[:id]
		    params[:style][:userid] = session[:user_id]
		    # Code to connect with API
		    @uri = URI.parse(src)
		    http = Net::HTTP.new(@uri.host,@uri.port)
		    params[:style][:name] = Rack::Utils.escape(params[:style][:name]) 
		    request = Net::HTTP::Post.new("/adexchange/publisher/style/#{id}")
					request.set_form_data({ "name" => params[:style][:styleName], "border" => params[:style][:BorderColor] ,"title" => params[:style][:TitleColor],
					"text"=> params[:style][:TextColor], "url"=>params[:style][:urlColor], "fontSize"=> params[:style][:fontsize] ,"userId"=> params[:style][:userid],
					"cornerStyle"=> params[:style][:cornerstyle], "fontFamily"=> params[:style][:fontfamily], "background"=>params[:style][:BackgroundColor] })
		    response = http.request(request)
		    # 'response' holds the respose data
		    code = response.code
		    if code == '200'
		      flash[:notice] = "You have Updated a style."
		      redirect_to '/styles/'
		    else
		      flash[:notice] = "Some error occured!Please try again"
		      redirect_to '/styles/#{id}/edit' 
		    end
		  # If form is not submitted.
		  else
		    # To get data of selected 'style id'
		    @sites=Publishersite.where(created_by: session[:user_id] , status: 'Active')
		    @id = id = params[:id]
		    # Code to connect with API
		    @uri = URI.parse(src)
		    http = Net::HTTP.new(@uri.host,@uri.port)
		    request = Net::HTTP::Get.new("/adexchange/publisher/style/#{id}")
		    response = http.request(request)
		    @parsed = JSON.parse(response.body)
		   	# '@parsed' holds data of selected 'style id'
				if @parsed["userId"] != session[:user_id]
					render_404
				else
					userId = session[:user_id]
				  @uri = URI.parse(src)
				  http = Net::HTTP.new(@uri.host,@uri.port)
				  request = Net::HTTP::Get.new("/adexchange/publisher/style/list/#{userId}")
					response = http.request(request)
					@allstyles = JSON.parse(response.body)
				end
		  end
		end
  end

  def update
      @style = Style.find(params[:id])
      if @style.update_attributes(params[:style])
        flash[:notice] = 'Style was successfully updated.'
        redirect_to "/styles/"
      else
        render "edit"
      end
  end

  # To delete the style.
  def destroy
    id = params[:id]
		src =  Tagaly3::SRC
    # Code to connect with API
    @uri = URI.parse(src)
    http = Net::HTTP.new(@uri.host,@uri.port)
    request = Net::HTTP::Delete.new("/adexchange/publisher/style/#{id}")
    response = http.request(request)
    redirect_to '/styles/'
  end

end

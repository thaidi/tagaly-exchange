class FontsController < ApplicationController
  layout 'createpublisher' 
  require 'net/http' 
  require 'json'
  require 'uri' 
	def new
		if session[:user_id] == '' || session[:user_id] == nil
			redirect_to '/login'
		else
			@allfonts = Font.where.not(id:0)
			@sites=Publishersite.where(created_by: session[:user_id] , status: 'Active')
			if params[:font]
				@font = Font.new
		 		ctime = (Time.now().to_f * 1000000).to_i
				url = ctime.to_s + params[:font][:file].original_filename
				publisherid = session[:user_id]
		   	@post = DataFile.savefont(params[:font][:file],url)
				insertQuery = "insert into fonts (name,url,publisherid,created_at,updated_at ) values ('#{params[:font][:name]}' , '#{url}' , '#{publisherid}' , now() , now() )"
				connection = ActiveRecord::Base.connection
				ActiveRecord::Base.connection.execute(insertQuery)
        flash[:notice] = "Font uploaded succesfully."
				redirect_to '/fonts/'
			end
		end
	end
	def index
		if session[:user_id] == '' || session[:user_id] == nil
			redirect_to '/login'
		else
			@sites = Publishersite.where(created_by: session[:user_id] , status: 'Active')
			@fonts = Font.where(publisherid: session[:user_id])
		end
	end

  def destroy
		@fontId = params[:id]
		@font = Font.find(@fontId)
		@url = @font.url
		@font.destroy
		File.delete(Rails.root + 'public/fonts/' + @url)
    flash[:notice] = "Font delete succesfully."
	  redirect_to "/fonts/"
  end
end

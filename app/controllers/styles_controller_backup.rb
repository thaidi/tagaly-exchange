class StylesController < ApplicationController
  layout 'publisher' 
  require 'net/http' 
  require 'json'
  require 'uri' 
def new

@sites=Publishersite.where(created_by: session[:user_id])
     @style = Style.new

    if params[:style]
      params[:style][:userid] = session[:user_id]
      params[:style][:usertype] = "publisher"

#@responser = JSON.parse(resp)
# userId=2&name=firstStyle123456789&border=none&title=Test&background=none&text=hai&url=http://www.google.com&cornerStyle=square&fontFamily=arial&fontSize=10

# Shortcut
# response = Net::HTTP.post_form(uri, {"name" => params[:style][:name], "border" => params[:style][:border] ,"title" => params[:style][:title], "background"=>params[:style][:background], "text"=> params[:style][:text], "url"=>params[:style][:url], "cornerStyle"=> params[:style][:cornerstyle], "userId"=> params[:style][:userid], "fontFamily"=> params[:style][:fontfamily], "fontSize"=> params[:style][:fontsize] })

@uri = URI.parse("http://myappone.com:9090")
http = Net::HTTP.new(@uri.host,@uri.port)
request = Net::HTTP::Put.new("/adexchange/publisher/style")
request.set_form_data({"name" => params[:style][:name], "border" => params[:style][:border] ,"title" => params[:style][:title], "background"=>params[:style][:background], "text"=> params[:style][:text], "url"=>params[:style][:url], "cornerStyle"=> params[:style][:cornerstyle], "userId"=> params[:style][:userid], "fontFamily"=> params[:style][:fontfamily], "fontSize"=> params[:style][:fontsize] })
response = http.request(request)
code = response.code

      if code == '200'
        flash[:notice] = "You have Added a style."
	if params[:style][:backto]
		redirect_to params[:style][:backto]
	else
        	redirect_to '/styles/'
	end
      else
        flash[:notice] = "Some error occured!Please try again"
        redirect_to '/styles/new' 
      end

# request = Net::HTTP::Put.new("adexchange/publisher/style")
# request.set_form_data({"name" => params[:style][:name], "border" => params[:style][:border] ,"title" => params[:style][:title], "background"=>params[:style][:background], "text"=> params[:style][:text], "url"=>params[:style][:url], "cornerStyle"=> params[:style][:cornerstyle], "userId"=> params[:style][:userid], "fontFamily"=> params[:style][:fontfamily], "fontSize"=> params[:style][:fontsize] })
# response = http.request(request)


# @resp=response.body
# @respcode = response.code
# @responser = JSON.parse(resp)

=begin
# Full control
http = Net::HTTP.new(uri.host, uri.port)

request = Net::HTTP::Post.new(uri.request_uri)
request.set_form_data({"q" => "My query", "per_page" => "50"})

response = http.request(request)
=end

    end
  end
  def index
    @sites=Publishersite.where(created_by: session[:user_id])

userId = session[:user_id]
@uri = URI.parse("http://myappone.com:9090")
http = Net::HTTP.new(@uri.host,@uri.port)
request = Net::HTTP::Get.new("/adexchange/publisher/style/list/#{userId}")
response = http.request(request)
@body = response.body
@parsed = JSON.parse(response.body)
# request.set_form_data({"name" => params[:style][:name], "border" => params[:style][:border] ,"title" => params[:style][:title], "background"=>params[:style][:background], "text"=> params[:style][:text], "url"=>params[:style][:url], "cornerStyle"=> params[:style][:cornerstyle], "userId"=> params[:style][:userid], "fontFamily"=> params[:style][:fontfamily], "fontSize"=> params[:style][:fontsize] })

code = response.code

    @allstyles =Style.where(userid: session[:user_id])
  end
  def edit
@sites=Publishersite.where(created_by: session[:user_id])
       @style = Style.find(params[:id])
       @sites=Publishersite.where(created_by: session[:user_id])
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

  def destroy
    @style = Style.find(params[:id])
    @style.destroy
    redirect_to '/styles/'
  end
end

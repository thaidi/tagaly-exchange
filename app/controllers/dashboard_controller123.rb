=begin
  controller for dashboard
=end
class DashboardController < ApplicationController
require 'net/http'
layout 'advertiser'
  def setsessions
    @sitese=Site.where(id: params[:id])
    @sitese.each do |sitei|
      session[:site_name] = sitei.siteName
      session[:site_id] = sitei.id
      session[:site_url] = sitei.siteUrl
    end
		redirect_to request.env["HTTP_REFERER"]
  end
  
  
  def index
    @sites = Site.where(advertiserId: session[:user_id])
    render :action=>'show'
  end
  def graph
    @sites = Site.where(advertiserId: session[:user_id])
  end
  
 
 #### DAshboard Starts Here............
  
  def show
    if params[:status] != nil
      @status=params[:status]
    else
    @status="All"
    end
    @sites = Site.where(advertiserId: session[:user_id])
    if params[:id].to_i != session[:site_id].to_i
	redirect_to "/dashboard/#{session[:site_id]}"
    end
    if !session[:startdate] and !session[:enddate] and !session[:value]
        session[:startdate] = Date.today - 29.days
        session[:enddate] = Date.today
        session[:datetype] = "5"
    end
    if session[:user_timezone] != nil
      @timezone=session[:user_timezone].dup
    else
      @timezone='UTC'
    end
    @timezone=@timezone.sub! '/', '%2F'
    @siteId=session[:site_id]
      src =  Tagaly3::SRC
      @uri = URI.parse(src)
      http = Net::HTTP.start(@uri.host,@uri.port)
      if params[:accessType]==nil || params[:accessType]=="site"
        request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/dashboard/siteId/#{@siteId}/#{@status}/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
      elsif params[:accessType]=="campaign"
        request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/dashboard/campaignId/#{params[:campaignId]}/#{@status}/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
      else
        request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/dashboard/siteId/#{@siteId}/active/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
      end
      response = http.request(request)


      #### Exception Handling
      begin
      @AdunitsData = JSON.parse(response.body)
      rescue Errno::ECONNREFUSED
      @failure =""
      rescue JSON::ParserError
      @failure =""
      else
      @success =""
      end
      
      @adsDataStats = @AdunitsData["stats"]
      @adsNumofRecords = @AdunitsData["numPages"]
      @adsTotals = @AdunitsData["totals"]
      request = Net::HTTP::Get.new("/adexchange/advertiser/campaign/dashboard/siteId/#{@siteId}/#{@status}/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
      response = http.request(request)

      #### Exception Handling
      begin
      @CampData = JSON.parse(response.body)
      rescue Errno::ECONNREFUSED
      @failure =""
      rescue JSON::ParserError
      @failure =""
      else
      @success =""
      end

      if session[:user_timezone] != nil
        session[:user_timezone]=@timezone.sub! '%2F','/'
      end
      @CampDataStats = @CampData["stats"]
      @CampTotals = @CampData["totals"]
      timeezone = @timezone
   if params[:displayType] == "domains"
      request = Net::HTTP::Get.new("/adexchange/advertiser/domains/dashboard/siteId/#{@siteId}/#{@status}/Asia/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
      response = http.request(request)
      @DomianData = JSON.parse(response.body)
      @DomianDataStats = @DomianData["stats"]
      @DomianDataTotals = @DomianData["totals"]
 
      #### Exception Handling
      begin
      @DomainsData = JSON.parse(response.body)
        rescue Errno::ECONNREFUSED     
        @failure =""
        rescue JSON::ParserError
    	@failure =""
        else
      	@success =""
     end
<<<<<<< HEAD
elsif params[:displayType] == "conversions"

      request = Net::HTTP::Get.new("/adexchange/advertiser/conversion/dashboard/siteId/#{@siteId}/Asia/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
      response = http.request(request)
			 begin
				@ConversionsData = JSON.parse(response.body)
if @ConversionsData.present? 
				@ConversionsDataStats = @ConversionsData["stats"]
				@ConversionsDataTotals = @ConversionsData["totals"]
else 
				@ConversionsDataStats = ""
				@ConversionsDataTotals = ""
end
       rescue Errno::ECONNREFUSED
				@failure =""
	     rescue JSON::ParserError
  	  	@failure =""
      else
=======
   elsif params[:displayType] == "conversions"
     request = Net::HTTP::Get.new("/adexchange/advertiser/conversion/dashboard/siteId/#{@siteId}/Asia/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
     response = http.request(request)
     begin
	@ConversionsData = JSON.parse(response.body)
	@ConversionsDataStats = @ConversionsData["stats"]
	@ConversionsDataTotals = @ConversionsData["totals"]
        rescue Errno::ECONNREFUSED
	@failure =""
	rescue JSON::ParserError
  	@failure =""
        else
>>>>>>> 766af0ec9abbf2443e151038cd51a58db57da02a
      	@success =""
     end
  end
  http.finish

      if params[:displayType]=="campaigns" && params[:accessType]==nil
        render 'campaigns' ,:layout => false
      elsif params[:displayType] == "ads"
        render 'ads' ,:layout => false
      elsif params[:displayType] == "domains"
        render 'domains' ,:layout => false
      elsif params[:displayType] == "conversions"
        render 'conversions' ,:layout => false
      end
      
      if params[:exportType]=="ads"

      headings=['Ad','Status','Impressions','Clicks','CTR','CPM','CPC','CPA','Conv.','Spend']
      column_names = headings
      s=CSV.generate do |csv|
	  csv << column_names
	  end
      if @adsDataStats.present?
	@adsDataStats.each do |key,ads|
	  hashes=[{'Ad'=>@adsDataStats[key]["advertisementDetails"]["adName"],'status'=>@adsDataStats[key]["advertisementDetails"]["adStatus"],'Impressions'=>@adsDataStats[key]["impressions"],'Clicks'=>@adsDataStats[key]["clicks"],'CTR'=>0,'CPM'=>@adsDataStats[key]["CPM"],'CPC'=>@adsDataStats[key]["CPC"],'CPA'=>@adsDataStats[key]["CPA"],'Conv.'=>0,'Spend'=> @adsDataStats[key]["advertisementDetails"]["cost"]}]
	 s=s + CSV.generate do |csv|
		  #csv << column_names
	 hashes.each do |x|
	 csv << x.values
		  end
		end
	end
	
	totals=["Total",'',@adsTotals["totImpressions"],@adsTotals["totClicks"],'0',@adsTotals["totCPM"],@adsTotals["totCPC"],@adsTotals["totCPA"],@adsTotals["totConversions"],@adsTotals["totCost"]];
	s=s + CSV.generate do |csv|
		  #csv << column_names
	 csv << totals
	 end
      end
    send_data s, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment;filename=ads.csv"
      elsif params[:exportType]=="campaigns"
        headings=['Campaign','Status','Impressions','Clicks','CTR','CPM','CPC','CPA','Conv.','Spend']
        column_names = headings
        s=CSV.generate do |csv|
	  csv << column_names
	end
	if @CampDataStats.present?
	  @CampDataStats.each do |key,ads|
	  hashes=[{'Campaign'=>@CampDataStats[key]["campaignDetails"]["campaignName"],'status'=>@CampDataStats[key]["campaignDetails"]["campaignStatus"],'Impressions'=>@CampDataStats[key]["impressions"],'Clicks'=>@CampDataStats[key]["click"],'CTR'=>0,'CPM'=>@CampDataStats[key]["CPM"],'CPC'=>@CampDataStats[key]["CPC"],'CPA'=>@CampDataStats[key]["CPA"],'Conv.'=>@CampDataStats[key]["conversions"],'Spend'=> @CampDataStats[key]["cost"]}]
	  s=s + CSV.generate do |csv|
	  hashes.each do |x|
	  csv << x.values
	     end
	   end
	  end
	  totals=["Total",'',@CampTotals["totImpressions"],@CampTotals["totClicks"],'0',@CampTotals["totCPM"],@CampTotals["totCPC"],@CampTotals["totCPA"],@CampTotals["totConversions"],@CampTotals["totCost"]];
	 s=s + CSV.generate do |csv|
	 csv << totals
	   end
	end
	send_data s, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment;filename=campaigns.csv"
      end
			
      
  end
  
  #### Dashboard Ends Here.........
  
  
end

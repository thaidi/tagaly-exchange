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
    if session[:user_id] == '' || session[:user_id] == nil
      redirect_to '/login'
    else

    if session[:site_id] == nil
          #flash[:notice]="Please create a new site before you proceed !"
          session[:return_to]=request.fullpath + "?aft=1"
          redirect_to '/sites'
    else
      @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
      if params[:aft]=='1'
        redirect_to "/dashboard/#{session[:site_id]}?aft=1"
      else
        redirect_to "/dashboard/#{session[:site_id]}"
      end
    end
  end
  end
  def graph
    @sites = Site.where(advertiserId: session[:user_id],siteStatus:"active")
  end
  
  #### The dashboard action
  def show
   
    if session[:user_id] == '' || session[:user_id] == nil
      redirect_to '/login'
    else
    siteDetails = Site.where(advertiserId: session[:user_id] , id: params[:id])
    if siteDetails.present?
      
      siteDetails.each do |sitei|
        if sitei['siteStatus'] == "active"
          session[:site_name] = sitei.siteName
          session[:site_id] = sitei.id
          session[:site_url] = sitei.siteUrl
        else
          flash[:notice] = "Please activate the site or Please select only active sites."
          redirect_to '/sites/'
        end
      end
    else
      flash[:notice] = "Please activate the site or Please select only active sites."
      redirect_to '/sites/'
    end
    if params[:status] != nil
      @status=params[:status]
      @campstatus=params[:status]
      @adstatus=params[:status]
    else
      @status="All"
      @campstatus="activerorpause"
      @adstatus="ActiveOrPaused"
    end
    if $campstatus == "" && $campstatus == nil
      $campstatus = "activerorpause"
    end
    if params[:displayType] == "campaigns"
      if params[:status] != nil
        $campstatus = params[:status]
      end
    end

    session[:dashboardGraphStatus]=@status
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
     #src="http://myappone.com:9090"
     #src="http://54.225.91.236:8080"
     #src="http://54.86.135.219:8080/"
     

     #src="http://54.86.135.219:8080/"
     

      @uri = URI.parse(src)
      http = Net::HTTP.start(@uri.host,@uri.port)
     # return false

      if params[:accessType]==nil || params[:accessType]=="site"
        request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/dashboard/siteId/#{@siteId}/#{@adstatus}/#{$campstatus}/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
      elsif params[:accessType]=="campaign"
        request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/dashboard/campaignId/#{params[:campaignId]}/#{@adstatus}/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
      else
        request = Net::HTTP::Get.new("/adexchange/advertiser/advertisement/dashboard/siteId/#{@siteId}/active/#{$campstatus}/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
      end
      response = http.request(request)
#render text: "/adexchange/advertiser/advertisement/dashboard/siteId/#{@siteId}/active/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10"
     
      begin
      @AdunitsData = JSON.parse(response.body)
      rescue Errno::ECONNREFUSED
      @failure =""
      rescue JSON::ParserError
      @failure =""
      else
      @success =""
      end
      #return false
      if @AdunitsData.present?
        @adsDataStats = @AdunitsData["stats"]
        @adsNumofRecords = @AdunitsData["numPages"]
        @adsTotals = @AdunitsData["totals"]
      else
        @adsDataStats=""
        @adsNumofRecords=""
        @adsTotals=""
      end
      
      request = Net::HTTP::Get.new("/adexchange/advertiser/campaign/dashboard/siteId/#{@siteId}/#{@status}/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
      #"/adexchange/advertiser/campaign/dashboard/siteId/#{@siteId}/#{@status}/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10"
		logger.debug "Ad Exchane Url /adexchange/advertiser/campaign/dashboard/siteId/#{@siteId}/#{@status}/#{@timezone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10"
      response = http.request(request)
       begin
      @CampData = JSON.parse(response.body)
      @CampDataStats = @CampData["stats"]
      $globalCampDataStats = @CampData["stats"]
      @CampTotals = @CampData["totals"]
      rescue Errno::ECONNREFUSED
      @failure =""
      rescue JSON::ParserError
      @failure =""
      rescue NoMethodError
      @failure =""
      else
      @success =""
      end

      if session[:user_timezone] != nil
        session[:user_timezone]=@timezone.sub! '%2F','/'
      end
      
      timeezone = @timezone
      #@testdata='camp'
if params[:displayType] == "domains" || params[:exportType] == "domain"
      #@testdata='domain'
      request = Net::HTTP::Get.new("/adexchange/advertiser/domains/dashboard/siteId/#{@siteId}/#{@status}/Asia/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
      response = http.request(request)
      @DomianData = JSON.parse(response.body)
      @DomianDataStats = @DomianData
      #["stats"]
      @DomianDataTotals = @DomianData["totals"]

       begin
        @DomainsData = JSON.parse(response.body)
       rescue Errno::ECONNREFUSED     
        @failure =""
     rescue JSON::ParserError
      @failure =""
      else
        @success =""
     end
elsif params[:displayType] == "conversions" || params[:exportType] == "conversion"
        @usrtimeZone = Rack::Utils.escape(session[:user_timezone])

      request = Net::HTTP::Get.new("/adexchange/advertiser/conversion/dashboard/siteId/#{@siteId}/Assigned/#{@usrtimeZone}/#{session[:startdate].to_s+"%2000:00:00"}/#{session[:enddate].to_s+"%2023:59:59"}/name/0/10")
      response = http.request(request)
       begin
        @ConversionsData = JSON.parse(response.body)
    if @ConversionsData.count > 0 
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
    hashes=[{'Ad'=>@adsDataStats[key]["advertisementDetails"]["adName"],'status'=>@adsDataStats[key]["advertisementDetails"]["adStatus"],'Impressions'=>@adsDataStats[key]["impressions"],'Clicks'=>@adsDataStats[key]["clicks"],'CTR'=>0,'CPM'=>@adsDataStats[key]["CPM"],'CPC'=>@adsDataStats[key]["CPC"],'CPA'=>@adsDataStats[key]["CPA"],'Conv.'=>0,'Spend'=> @adsDataStats[key]["cost"]}]
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
        headings=['Campaign','Status','Budget','BidType','Impressions','Clicks','CTR','CPM','CPC','CPA','Conv.','Spend']
        column_names = headings
        s=CSV.generate do |csv|
    csv << column_names
  end

  if @CampDataStats.present?
    @CampDataStats.each do |key,ads|
    hashes=[{'Campaign'=>@CampDataStats[key]["campaignDetails"]["campaignName"],'status'=>@CampDataStats[key]["campaignDetails"]["campaignStatus"],'Budget'=>@CampDataStats[key]["campaignDetails"]["budget"],'BidType'=>@CampDataStats[key]["campaignDetails"]["bidType"],'Impressions'=>@CampDataStats[key]["impressions"],'Clicks'=>@CampDataStats[key]["clicks"],'CTR'=>@CampDataStats[key]["CTR"],'CPM'=>@CampDataStats[key]["CPM"],'CPC'=>@CampDataStats[key]["CPC"],'CPA'=>@CampDataStats[key]["CPA"],'Conv.'=>@CampDataStats[key]["conversions"],'Spend'=> @CampDataStats[key]["cost"]}]
    s=s + CSV.generate do |csv|
    hashes.each do |x|
    csv << x.values
       end
   
     end
    end
    totals=["Total",'','','',@CampTotals["totImpressions"],@CampTotals["totClicks"],@CampTotals["totCTR"],@CampTotals["totCPM"],@CampTotals["totCPC"],@CampTotals["totCPA"],@CampTotals["totConversions"],@CampTotals["totCost"]];
   s=s + CSV.generate do |csv|
   csv << totals
     end
  end
  send_data s, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment;filename=campaigns.csv"
#//st     
elsif params[:exportType]=="conversion"
        headings=['ConversionGoalName','Type','Conversion Path','ConversionCounting','Conversions']
        column_names = headings
        s=CSV.generate do |csv|
    csv << column_names
  end

  if @ConversionsDataStats.present?
    @ConversionsDataStats.each do |key,camps|
      @convCounting = @ConversionsDataStats[key]["ConversionDetails"]["conversionCounting"]
        if @convCounting == "every"
          @convCounting = "Count every conversion"
        else
          @convCounting = "Count once per user"
        end
    hashes=[{'ConversionGoalName'=>@ConversionsDataStats[key]["ConversionDetails"]["conversionName"],'Type'=>@ConversionsDataStats[key]["ConversionDetails"]["conversionType"],'ConversionPath'=>@ConversionsDataStats[key]["ConversionDetails"]["conversionTypeValue"],'ConversionCounting'=>@convCounting,'Conversions'=>@ConversionsDataStats[key]["conversions"]}]
    s=s + CSV.generate do |csv|
    hashes.each do |x|
    csv << x.values
       end
   
     end
    end
    totals=["Total",'','','',@ConversionsDataTotals["totConversions"]];
   s=s + CSV.generate do |csv|
   csv << totals
     end
  end
  send_data s, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment;filename=converisons.csv"
  
  elsif params[:exportType]=="domain"
        headings=['Site','Impressions','Clicks','CTR','CPM','CPC','CPA','Conv.','Spend']
        column_names = headings
        s=CSV.generate do |csv|
    csv << column_names
  end

  if @DomianDataStats.present?
    @DomianDataStats.each do |key,domains|
      if @DomianDataStats[key]["clicks"].to_i != 0
  convRate = @DomianDataStats[key]["conversions"].to_i / @DomianDataStats[key]["clicks"].to_i
   else
  convRate = 0
   end
   if @DomianDataStats[key]["impressions"].to_i != 0
  ctr = (@DomianDataStats[key]["clicks"].to_i / @DomianDataStats[key]["impressions"].to_i)*100
   else
  ctr = 0
   end
   if @DomianDataStats[key]["conversions"].to_i != 0
  cpa = @DomianDataStats[key]["cost"].to_i / @DomianDataStats[key]["conversions"].to_i
   else
  cpa = 0
   end
   if key=="totals"
     break
   end
    hashes=[{'Site'=>key,'Impressions'=>@DomianDataStats[key]["impressions"],'Clicks'=>@DomianDataStats[key]["clicks"],'CTR'=>@DomianDataStats[key]["CTR"],'CPM'=>@DomianDataStats[key]["CPM"],'CPC'=>@DomianDataStats[key]["CPC"],'CPA'=>@DomianDataStats[key]["CPA"],'Conv.'=>@DomianDataStats[key]["conversions"],'Spend'=>@DomianDataStats[key]["cost"]}]
    s=s + CSV.generate do |csv|
    hashes.each do |x|
    csv << x.values
       end
   
     end
    end

    if @DomianDataStats.count>1
        if @DomianDataTotals.present?
          if @DomianDataTotals["totClicks"].to_i != 0
  totconvRate = @DomianDataTotals["totConversions"].to_i / @DomianDataTotals["totClicks"].to_i
   else
  totconvRate = 0
   end
   if @DomianDataTotals["totImpressions"].to_i != 0
  # totctr = @DomianDataTotals["totClicks"].to_i * 100 / @DomianDataTotals["totImpressions"].to_i
  totctr = 0
   else
  totctr = 0
   end
   if @DomianDataTotals["totConversions"].to_i != 0
  totcpa = @DomianDataTotals["totCost"].to_i / @DomianDataTotals["totConversions"].to_i
   else
  totcpa = 0
   end
   end
   end
    totals=["Total",@DomianDataTotals["totImpressions"],@DomianDataTotals["totClicks"],@DomianDataTotals["totCTR"],@DomianDataTotals["totCPM"],@DomianDataTotals["totCPC"],@DomianDataTotals["totCPA"],@DomianDataTotals["totConversions"],@DomianDataTotals["totCost"]];
   s=s + CSV.generate do |csv|
   csv << totals
     end
  end
  send_data s, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment;filename=domains.csv"
#//end
      end
     
  end
  end
end


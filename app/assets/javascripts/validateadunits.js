function validateadunit()
{
				if(document.getElementById("adunitsstring").value.trim() == "")
				{
						document.getElementById("aduniterrorText").innerHTML="Please select atleast one AdUnit from the sites";
				    document.getElementById("aduniterrorText").style.display="block";
				    return false ;
				}
				else
				{
				   document.getElementById("aduniterrorText").style.display="none";
				   return true;
				}
}

function validateads()
{
	var adCheckboxs=document.getElementsByClassName("ads");
    var checkedAtLeastOneAd=false;
    for(var i=0,l=adCheckboxs.length;i<l;i++)
    {
        if(adCheckboxs[i].checked)
        {
            checkedAtLeastOneAd=true;
        }
    }
    if(checkedAtLeastOneAd)
    {
       document.getElementById("aderrorText").style.display="none";
	   return true;
    }
    else
    {
       document.getElementById("aderrorText").innerHTML="Please select atleast one Ad";
       document.getElementById("aderrorText").style.display="block";
	   return false
    }
}

//validate campaign setting
function validateCampaignSettings()
{
    //Retargets validation
    var checkedAtLeastOneRetarget=true;
    var retargetCheckboxs=document.getElementsByClassName("retargets");
    if(document.getElementById("allretargetlists").checked==false)
    {
	    checkedAtLeastOneRetarget=false;
	    for(var i=0,l=retargetCheckboxs.length;i<l;i++)
	    {
		if(retargetCheckboxs[i].checked)
		{
		    checkedAtLeastOneRetarget=true;
		}
	    }
	    if(checkedAtLeastOneRetarget)
	    {
	       document.getElementById("retargeterrorText").style.display="none";
	    }
	    else
	    {
	       document.getElementById("retargeterrorText").innerHTML="Please select atleast one Retarget";
	       document.getElementById("retargeterrorText").style.display="block";

	    }
    }
//Conversions validation
    var conversionGoalsCheckboxs=document.getElementsByClassName("conversionGoals");
    if(document.getElementById("campaigntype") && document.getElementById("campaigntype").value=="cpa")
    {
		  var checkedAtLeastOneconversionGoal=false;
		  for(var i=0,l=conversionGoalsCheckboxs.length;i<l;i++)
		  {
		      if(conversionGoalsCheckboxs[i].checked)
		      {
		          checkedAtLeastOneconversionGoal=true;
		      }
		  }
    }
    else
    {
    	var checkedAtLeastOneconversionGoal=true;
    }
    if(checkedAtLeastOneconversionGoal)
    {
       document.getElementById("conversionGoalerrorText").style.display="none";
    }
    else
    {
       document.getElementById("conversionGoalerrorText").innerHTML="Please select atleast one Conversion Goal";
       document.getElementById("conversionGoalerrorText").style.display="block";

    }
    
    // Validate geotargeting
    var validateGeotargeting=false;

    if(document.getElementById("campaign_geotargeting_all").checked==true)
    {
    	validateGeotargeting=true;
    }
    else if(document.getElementById("campaign_geotargeting_countries").checked==true)
    {
    	if(document.getElementById("countries").value.trim() == "")
    	{
    		 document.getElementById("geoCountrieserrorText").innerHTML="Please fill in the countries!";
       		 document.getElementById("geoCountrieserrorText").style.display="block";
    		 validateGeotargeting=false;
    	}
    	else
    	{
    		document.getElementById("geoCountrieserrorText").style.display="none";
    		validateGeotargeting=true;
    	}
    }
    else
    {
    	if(document.getElementById("dmas").value.trim() == "")
    	{
    		 document.getElementById("geoDmaserrorText").innerHTML="Please fill in the Dmas!";
       		 document.getElementById("geoDmaserrorText").style.display="block";
    		 validateGeotargeting=false;
    	}
    	else
    	{
    		validateGeotargeting=true;
    		document.getElementById("geoDmaserrorText").style.display="none";
    	}
    }
    //Validate campaign name
    validateCampaignName=false;
    if(document.getElementById("campaign_name").value.trim() == "")
    {
    	document.getElementById("campaignNameerrorText").innerHTML="Please fill in the Campaign Name!";
       	document.getElementById("campaignNameerrorText").style.display="block";
    	validateCampaignName=false
    }
    else
    {
    	checkCampaignName(document.getElementById("campaign_name").value);
    	document.getElementById("campaignNameerrorText").style.display="none";
    	validateCampaignName=true;
    }
    //Validate campaign budget
    validateCampaignBudget=false;
    if(document.getElementById("weekly_budget").value.trim() == "")
    {
    	document.getElementById("budgeterrorText").innerHTML="Please fill in the Campaign Budget!";
       	document.getElementById("budgeterrorText").style.display="block";
    	validateCampaignBudget=false
    }
    else
    {
    	if(isNaN(document.getElementById("weekly_budget").value))
    	{
    		document.getElementById("budgeterrorText").innerHTML="Campaign Budget should be a valid integer!";
       		document.getElementById("budgeterrorText").style.display="block";
    		validateCampaignBudget=false
    	}
    	else if(parseInt(document.getElementById("weekly_budget").value.trim()) <= 0)
    	{
    		document.getElementById("budgeterrorText").innerHTML="Campaign Budget should be a more than zero!";
       		document.getElementById("budgeterrorText").style.display="block";
    		validateCampaignBudget=false
    	}
    	else
    	{
    	  var n = document.getElementById("weekly_budget").value.toString().split('.');
    	  var decimalpoints=['0'];
		    if(n.length >= 2)
		    {
		    	var decimalpoints=n[1];
		    }
				if(decimalpoints.length <= 2)
				{
					var bdgt=parseFloat(document.getElementById("weekly_budget").value);
					document.getElementById("weekly_budget").value=bdgt.toFixed(2);
						document.getElementById("budgeterrorText").style.display="none";
    				validateCampaignBudget=true
				}
				else
				{
						document.getElementById("budgeterrorText").style.display = 'block';
		        document.getElementById("budgeterrorText").innerHTML = 'Please enter only two digits after the decimal point !';
		        validateCampaignBudget=false ;
				}
    		
    	}
    }
    validatestartend=false;
    if(document.getElementById("run-campaign-continuously").checked==false)
    {
    	if(document.getElementById("campaign_start_date").value.trim() == "")
    	{
    		document.getElementById("startDateerrortext").innerHTML="Please select the start date!";
    		document.getElementById("startDateerrortext").style.display="block";
    		validatestartend=false;
    		
    	}
    	else if(document.getElementById("campaign_end_date").value.trim() == "")
    	{
    		document.getElementById("startDateerrortext").style.display="none";
    		document.getElementById("endDateerrortext").innerHTML="Please select the end date!";
    		document.getElementById("endDateerrortext").style.display="block";
    		validatestartend=false;
    	}
    	else
    	{
    		document.getElementById("endDateerrortext").style.display="none";
    		document.getElementById("startDateerrortext").style.display="none";
    		validatestartend=true;
    	}
    }
    else
    {
    	validatestartend=true;
    }
    
    bidValidation1=false;
    bidValidation2=false;
    var validatebidtype1=""
    var validatebidtype2=""
    var bidType=document.getElementById("bidtype");
    if(bidType.value=="cpm")
    {
      validatebidtype1="impressions";
      validatebidtype2="campaign_cpm";
    }
    else if(bidType.value=="cpc")
    {
      validatebidtype1="clicks";
      validatebidtype2="campaign_cpc";
    }
    else if(bidType.value=="cpa")
    {
      validatebidtype1="conversions";
      validatebidtype2="campaign_cpa";
    }
    if(document.getElementById(validatebidtype1).value.trim()=="")
    {
          document.getElementById(validatebidtype1+"error").style.display = 'block';
          document.getElementById(validatebidtype1+"error").innerHTML = 'Please fill this field !';
          document.getElementById("form-"+bidType.value).style.marginTop="-73px" 
          
          bidValidation1=false ;
    }
    else if(isNaN(document.getElementById(validatebidtype1).value) == true)
    {
          document.getElementById(validatebidtype1+"error").style.display = 'block';
          document.getElementById(validatebidtype1+"error").innerHTML = 'Value should be a valid number !';
          document.getElementById("form-"+bidType.value).style.marginTop="-73px" 
          bidValidation1=false ;
    }
    else if(parseInt(document.getElementById(validatebidtype1).value) < 1 ||  parseInt(document.getElementById(validatebidtype1).value) > 9223372036854775807)
			{
					document.getElementById(validatebidtype1+"error").style.display = 'block';
          document.getElementById(validatebidtype1+"error").innerHTML = 'Value should be in the range 1 to 9223372036854775807';
          document.getElementById("form-"+bidType.value).style.marginTop="-73px" 
          bidValidation1=false ;
			}
    else
    {
    	document.getElementById(validatebidtype1).value=parseInt(document.getElementById(validatebidtype1).value);
      document.getElementById(validatebidtype1+"error").style.display = 'none';
      document.getElementById("form-"+bidType.value).style.marginTop="-53px" 
          bidValidation1=true;
    }
    
    
    if(document.getElementById(validatebidtype2).value.trim()=="")
    {
          document.getElementById(validatebidtype2+"error").style.display = 'block';
          document.getElementById(validatebidtype2+"error").innerHTML = 'Please fill this field !';
          bidValidation2=false ;
    }
    else if(isNaN(document.getElementById(validatebidtype2).value) == true)
    {
          document.getElementById(validatebidtype2+"error").style.display = 'block';
          document.getElementById(validatebidtype2+"error").innerHTML = 'Value should be a valid number !';
          bidValidation2=false ;
    }
    else if(parseInt(document.getElementById(validatebidtype1).value)<= 0)
    {
          document.getElementById(validatebidtype1+"error").style.display = 'block';
          document.getElementById(validatebidtype1+"error").innerHTML = 'Value should be greater than zero !';
          document.getElementById("form-"+bidType.value).style.marginTop="-73px" 
          bidValidation1=false ;
    }
    else
    {
    
      var n = document.getElementById(validatebidtype2).value.toString().split('.');
      var decimalpoints=['0'];
      if(n.length >= 2)
      {
      	var decimalpoints=n[1];
      }
			if(decimalpoints.length <= 2)
			{
					if(document.getElementById(validatebidtype2).value > 1000)
					{
						document.getElementById(validatebidtype2+"error").style.display = 'block';
		        document.getElementById(validatebidtype2+"error").innerHTML = 'Value cannot be more than 1000 !';
		        bidValidation2=false ;
					}
					else
					{
						document.getElementById(validatebidtype2).value=parseFloat(document.getElementById(validatebidtype2).value).toFixed(2);
						document.getElementById(validatebidtype2+"error").style.display = 'none';
		        bidValidation2=true;
		      }
			}
			else
			{
				  document.getElementById(validatebidtype2+"error").style.display = 'block';
          document.getElementById(validatebidtype2+"error").innerHTML = 'Please enter only two digits after the decimal point !';
          bidValidation2=false ;
			}
      
    }
    if(document.getElementById("run-ad-continuously").checked==false)
    {
	    var table = document.getElementById("dayparting");
	    var rowCount = table.rows.length;;
	   // var validateCampaignEndHr=false;
	    for(var i= 1 ; i<= rowCount ; i++)
	    {
	    	var endHr=document.getElementById("campaign_dayparting_end_hr"+i).value;
	    	var endMin=document.getElementById("campaign_dayparting_end_min"+i).value;
	    	var startHr=document.getElementById("campaign_dayparting_start_hr"+i).value;
	    	var startMin=document.getElementById("campaign_dayparting_start_min"+i).value;
	    	var start=new Date("October 13, 1975 "+startHr+":"+startMin+":00");
	    	var startts=start.getTime() ;
	    	
	    	var end=new Date("October 13, 1975 "+endHr+":"+endMin+":00");
	    	var endts=end.getTime() ;
	    	if(parseInt(endts) <= parseInt(startts))
	    	{
	    		document.getElementById("cenderror"+i).style.display="block";
	    		document.getElementById("campaign_dayparting_end_hr"+i).style.marginTop="37px";
	    		document.getElementById("cenderror"+i).innerHTML="End time cannot be before or equal to start time ! ";
	    		//validateCampaignEndHr=false ;
	    		return false;
	    	}
	    	else
	    	{
	    		document.getElementById("campaign_dayparting_end_hr"+i).style.marginTop="0px";
	    		document.getElementById("cenderror"+i).style.display="none";
	    		//validateCampaignEndHr=true ;
	    	}
	    	
	    	
	    }

    }
    else
    {
    	validateCampaignEndHr=true;
    }
    validateAdUnit=true

  //bidValidation1==false || bidValidation2==false ||  
    if(checkedAtLeastOneRetarget==false || checkedAtLeastOneconversionGoal==false || validateGeotargeting==false || validateCampaignName==false || validateCampaignBudget==false || bidValidation1==false || bidValidation2==false || validatestartend==false || validateAdUnit == false || campaignExists==false)
    {
    	return false
    }
    else
    {
    	return true;
    }
	
}

	//validate campaign setting
	function validateCampaignSettingsAdunits() {

    //Validate campaign name
    validateCampaignName=false;
		var campName = document.getElementById("campaign_name").value.trim();
    if(campName == "") {
			document.getElementById("campaignNameerrorText").innerHTML="Please fill in the Campaign Name!";
			document.getElementById("campaignNameerrorText").style.display="block";
			validateCampaignName = false;
			return false;
    } else {
  		checking = document.getElementById("campaignExists").value;
			if(checking == "no") {
				document.getElementById("campaignNameerrorText").innerHTML="";
				document.getElementById("campaignNameerrorText").style.display="none";
				validateCampaignName = true;
			} else if(checking == "yes") {
				document.getElementById("campaignNameerrorText").innerHTML="Campaign name already exists";
				document.getElementById("campaignNameerrorText").style.display="block";
				validateCampaignName = false;
			} else {
				document.getElementById("campaignNameerrorText").innerHTML="Please wait while we are checking the existance of campaign name.";
				document.getElementById("campaignNameerrorText").style.display="block";
				validateCampaignName = false;
			}
    }

				validatestartend=false;
				if(document.getElementById("run-campaign-continuously").checked==false) {
					if(document.getElementById("campaign_start_date").value.trim() == "") {
						document.getElementById("startDateerrortext").innerHTML="Please select the start date!";
						document.getElementById("startDateerrortext").style.display="block";
						validatestartend=false;
					} else if(document.getElementById("campaign_end_date").value.trim() == "") {
						document.getElementById("startDateerrortext").style.display="none";
						document.getElementById("endDateerrortext").innerHTML="Please select the end date!";
						document.getElementById("endDateerrortext").style.display="block";
						validatestartend=false;
					} else {
						document.getElementById("endDateerrortext").style.display="none";
						document.getElementById("startDateerrortext").style.display="none";
						validatestartend=true;
					}
				} else {
					validatestartend = true;
				}

				//Conversions validation
				var conversionGoalsCheckboxs=document.getElementsByClassName("conversionGoals");
				if(document.getElementById("campaigntype") && document.getElementById("campaigntype").value=="cpa") {
					var checkedAtLeastOneconversionGoal=false;
					for(var i=0,l=conversionGoalsCheckboxs.length;i<l;i++) {
						  if(conversionGoalsCheckboxs[i].checked) {
						      checkedAtLeastOneconversionGoal=true;
						  }
					}
				} else {
					var checkedAtLeastOneconversionGoal=true;
				}
				if(checkedAtLeastOneconversionGoal) {
				   document.getElementById("conversionGoalerrorText").style.display="none";
				} else {
				   document.getElementById("conversionGoalerrorText").innerHTML="Please select atleast one Conversion Goal";
				   document.getElementById("conversionGoalerrorText").style.display="block";
				}

				if(validateCampaignName == false || checkedAtLeastOneconversionGoal == false || validatestartend == false ) {
					return false
				} else {
					return true;
				}
	}

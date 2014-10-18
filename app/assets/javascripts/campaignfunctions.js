		function validate(id,divId) {
		value = $( "#" + id ).val();
		if(divId == "impressionserror") {
			msg = "Name Field cannot be blank";
		} else if(divId == "campaign_cpmerror") {
			msg = " Field cannot be blank";
		} 
		else if(divId == "clickserror") {
			msg = " Field cannot be blank";
		} 
		else if(divId == "campaign_cpcerror") {
			msg = " Field cannot be blank";
		} 
		else if(divId == "campaign_cpaerror") {
			msg = " Field cannot be blank";
		} 
		else if(divId == "conversionserror") {
			msg = " Field cannot be blank";
		} 
		else if(divId == "campaignNameerrorText") {
			msg = " Field cannot be blank";
		} 
		else if(divId == "budgeterrorText") {
			msg = " Field cannot be blank";
		} 
		
		if($( "#" + id ).hasClass( "req" )) {
			if(value.trim().length == 0) {
			
				document.getElementById(divId).innerHTML = msg;
				document.getElementById(divId).style.display = "flex";
				return false;
			} else {
				document.getElementById(divId).innerHTML = "";
				document.getElementById(divId).style.display = "none";
			}
		}
		if(id=="impressions" || id=="clicks" || id=="conversions")
		{
				if($( "#" + id ).hasClass( "numeric" )) {
							Impression = value;
							if(isNaN(Impression)){
								document.getElementById(id+"error").innerHTML = "Please give only integer values";
								document.getElementById(id+"error").style.display = "inline";
								if(id=="impressions")
								{
									document.getElementById("form-cpm").style.marginTop = "-71px";
								}
								else if(id=="clicks")
								{
									document.getElementById("form-cpc").style.marginTop = "-71px";
								}
								else if(id=="conversions")
								{
									document.getElementById("form-cpa").style.marginTop = "-71px";
								}
								return false;
							} else if (Impression < 0)
							{
								document.getElementById(id+"error").innerHTML = "Please give only positive integer values";
								document.getElementById(id+"error").style.display = "inline";
								if(id=="impressions")
								{
									document.getElementById("form-cpm").style.marginTop = "-71px";
								}
								else if(id=="clicks")
								{
									document.getElementById("form-cpc").style.marginTop = "-71px";
								}
								else if(id=="conversions")
								{
									document.getElementById("form-cpa").style.marginTop = "-71px";
								}
								return false;
							} else if(Impression > 9223372036854775807){
								document.getElementById(id+"error").innerHTML = "Value should be below 9223372036854775807";
								document.getElementById(id+"error").style.display = "inline";
								if(id=="impressions")
								{
									document.getElementById("form-cpm").style.marginTop = "-71px";
								}
								else if(id=="clicks")
								{
									document.getElementById("form-cpc").style.marginTop = "-71px";
								}
								else if(id=="conversions")
								{
									document.getElementById("form-cpa").style.marginTop = "-71px";
								}
								return false;
							}
							else
							{
								if(id=="impressions")
								{
									document.getElementById("form-cpm").style.marginTop = "-57px";
								}
								else if(id=="clicks")
								{
									document.getElementById("form-cpc").style.marginTop = "-57px";
								}
								else if(id=="conversions")
								{
									document.getElementById("form-cpa").style.marginTop = "-57px";
								}
							}
						}
			}
			if(id=="campaign_cpm" || id=="campaign_cpc" || id=="campaign_cpa")
			{
				if($( "#" + id ).hasClass( "numeric" )) 
				{
					 CPM = value;
					if(isNaN(CPM)){
						document.getElementById(id+"error").innerHTML = "Please give only integer values";
						document.getElementById(id+"error").style.display = "inline";
						if(id=="campaign_cpm")
						{
							if(document.getElementById("impressionserror").style.display=="none")
							{
								document.getElementById("form-cpm").style.marginTop = "-57px";
							}
							else
							{
								document.getElementById("form-cpm").style.marginTop = "-73px";
							}
						}
						else if(id=="campaign_cpc")
						{
							if(document.getElementById("clickserror").style.display=="none")
							{
								document.getElementById("form-cpc").style.marginTop = "-57px";
							}
							else
							{
								document.getElementById("form-cpc").style.marginTop = "-73px";
							}
						}
						else if(id=="campaign_cpa")
						{
							if(document.getElementById("conversionserror").style.display=="none")
							{
								document.getElementById("form-cpa").style.marginTop = "-57px";
							}
							else
							{
								document.getElementById("form-cpa").style.marginTop = "-73px";
							}
						}
						return false;
					} else if (CPM < 0){
						document.getElementById(id+"error").innerHTML = "Please give only positive integer values";
						document.getElementById(id+"error").style.display = "inline";
						if(id=="campaign_cpm")
						{
							if(document.getElementById("impressionserror").style.display=="none")
							{
								document.getElementById("form-cpm").style.marginTop = "-57px";
							}
							else
							{
								document.getElementById("form-cpm").style.marginTop = "-73px";
							}
							
						}
						else if(id=="campaign_cpc")
						{
							if(document.getElementById("clickserror").style.display=="none")
							{
								document.getElementById("form-cpc").style.marginTop = "-57px";
							}
							else
							{
								document.getElementById("form-cpc").style.marginTop = "-73px";
							}
						}
						else if(id=="campaign_cpa")
						{
							if(document.getElementById("conversionserror").style.display=="none")
							{
								document.getElementById("form-cpa").style.marginTop = "-57px";
							}
							else
							{
								document.getElementById("form-cpa").style.marginTop = "-73px";
							}
						}
						return false;
					} else if(CPM > 1000){
						document.getElementById(id+"error").innerHTML = "Value should be below 1000";
						document.getElementById(id+"error").style.display = "inline";
						if(id=="campaign_cpm")
						{
								if(document.getElementById("impressionserror").style.display=="none")
							{
								document.getElementById("form-cpm").style.marginTop = "-57px";
							}
							else
							{
								document.getElementById("form-cpm").style.marginTop = "-73px";
							}
						}
						else if(id=="campaign_cpc")
						{
							if(document.getElementById("clickserror").style.display=="none")
							{
								document.getElementById("form-cpc").style.marginTop = "-57px";
							}
							else
							{
								document.getElementById("form-cpc").style.marginTop = "-73px";
							}
						}
						else if(id=="campaign_cpa")
						{
							if(document.getElementById("conversionserror").style.display=="none")
							{
								document.getElementById("form-cpa").style.marginTop = "-57px";
							}
							else
							{
								document.getElementById("form-cpa").style.marginTop = "-73px";
							}
						}
						return false;
					}
				}
			}
			
			if(id=="weekly_budget"){
			 budget= value;


			if(isNaN(budget)){
				document.getElementById("budgeterrorText").innerHTML = "Please give only integer values";
				document.getElementById("budgeterrorText").style.display = "inline";
				return false;
			} else if (budget < 0){
				document.getElementById("budgeterrorText").innerHTML = "Please give only positive integer values";
				document.getElementById("budgeterrorText").style.display = "inline";
				return false;
			} 
		}

}

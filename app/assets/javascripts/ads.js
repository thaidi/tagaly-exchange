	function text_submitform() {
		var size = $(".error").size()
		nodes = document.getElementsByClassName("error");
		for(var i=0;i<size;i++) {
			nodes[i].style.display = "none"
		}
		var AdName = document.getElementById("text_ad_name").value;
		var destination_url = document.getElementById("text_destination_url").value;
		var text_display_url = document.getElementById("text_display_url").value;
		var ad_facebook_title = document.getElementById("text_ad_text_title").value;
		var ad_facebook_body = document.getElementById("text_ad_text_body").value;
		var Exp = /^[0-9a-zA-Z @!#\$\^%&*()+=\-\[\]\\\';,\.\/\{\}\|\":<>\?\n]+$/;
		if(AdName == '') {
			document.getElementById("AdNameError").innerHTML = "Please provide Ad name";
			document.getElementById("AdNameError").style.display = "inline";
			return false;
		} else {
			var adNameExistance = document.getElementById("adNameExistance").value;
			if(adNameExistance == "exist") {
				document.getElementById("AdNameError").innerHTML = "Ad with '" + AdName + "' already exists";
				document.getElementById("AdNameError").style.display = "inline";
				document.getElementById("AdNameError").style.width = "350px";
				return false;
			}
			// checkAdName(AdName,'text');
		}
		if(ad_facebook_title == ''){
			document.getElementById("HeadeLineError").innerHTML = "Please provide a Headline title";
			document.getElementById("HeadeLineError").style.display = "inline";
			validateHeadLine=0
			return false;
		} else {
			if(ad_facebook_title.length > 25){
				document.getElementById("HeadeLineError").innerHTML = "Headline cannot be more than more than 25 character length";
				document.getElementById("HeadeLineError").style.display = "inline";
				return false;
			}
		}
		if(destination_url == '') {
			document.getElementById("DestUrlError").innerHTML = "Please give a valid URL";
			document.getElementById("DestUrlError").style.display = "inline";
			return false;
		} else {
			if(!destination_url.match(/(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/)) {
				document.getElementById("DestUrlError").innerHTML = "Please give a valid URL";
				document.getElementById("DestUrlError").style.display = "inline";
				return false;
			} else {
				if( destination_url.length > 1024 ) {
					document.getElementById("DestUrlError").innerHTML = "Url cannot be longer than 1024 char length";
					document.getElementById("DestUrlError").style.display = "inline";
					return false;
				}
			}
		}
		if(text_display_url == ''){
			document.getElementById("DisplayUrlError").innerHTML = "Please give a valid URL";
			document.getElementById("DisplayUrlError").style.display = "inline";
			return false;
		} else {
			if(!text_display_url.match(/((?:https?\:\/\/|www\.)(?:[-a-z0-9]+\.)*[-a-z0-9]+.*)/i)) {
				document.getElementById("DisplayUrlError").innerHTML = "Please give a valid URL";
				document.getElementById("DisplayUrlError").style.display = "inline";
				return false;
			}
			else
			{
				if(text_display_url.length > 35 ) {
					document.getElementById("DisplayUrlError").innerHTML = "Url cannot be longer than 35 char length";
					document.getElementById("DisplayUrlError").style.display = "inline";
					return false;
				}
			}
		}
		if(ad_facebook_body == ''){
			document.getElementById("TextError").innerHTML = "Please provide some text";
			document.getElementById("TextError").style.display = "inline";
			return false;
		} else {
			if(ad_facebook_body.length > 70){
				document.getElementById("TextError").innerHTML = "Text cannot be more than more than 70 character length";
				document.getElementById("TextError").style.display = "inline";
				return false;
			}
		}
		if(adExists == false) {
			return false ;
		} else {
			return true ;
		}
	}

	function banner_submitform(){
		var size = $(".error").size()
		nodes = document.getElementsByClassName("error");
		for(var i=0;i<size;i++){
			nodes[i].style.display = "none"
		}
		var AdName = document.getElementById("banner_ad_name").value;
		var destination_url = document.getElementById("banner_destination_url").value;
		var Exp = /^[0-9a-zA-Z @!#\$\^%&*()+=\-\[\]\\\';,\.\/\{\}\|\":<>\?]+$/;
		var imageCode = document.getElementById("imageCode_banner").value;
		if(AdName == ''){
			document.getElementById("banner_AdNameError").innerHTML = "Please provide Ad name";
			document.getElementById("banner_AdNameError").style.display = "inline";
			return false;
		} else {
			var adNameExistance = document.getElementById("adNameExistance").value;
			if(adNameExistance == "exist") {
				document.getElementById("AdNameError").innerHTML = "Ad with '" + AdName + "' already exists";
				document.getElementById("AdNameError").style.display = "inline";
				document.getElementById("AdNameError").style.width = "350px";
				return false;
			}
			// checkAdName(AdName,'banner');
		}
		if(destination_url == ''){
			document.getElementById("banner_DestUrlError").innerHTML = "Please give a valid URL";
			document.getElementById("banner_DestUrlError").style.display = "inline";
			return false;
		} else {
			if(!destination_url.match(/(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/)) {
				document.getElementById("banner_DestUrlError").innerHTML = "Please give a valid URL";
				document.getElementById("banner_DestUrlError").style.display = "inline";
				return false;
			} else {
				if( destination_url.length > 1024 ) {
					document.getElementById("banner_DestUrlError").innerHTML = "Url cannot be longer than 1024 char length";
					document.getElementById("banner_DestUrlError").style.display = "inline";
					return false;
				}
			}
		}
		if(imageCode == ''){
			document.getElementById("banner_ImageError").innerHTML = "Please give a valid Image, Please check prefered size.";
			document.getElementById("banner_ImageError").style.display = "inline";
			return false;
		}
		if(adExists==false) {
			return false ;
		} else {
			return true ;
		}
	}
	function native_submitform(){
		var size = $(".error").size()
		nodes = document.getElementsByClassName("error");
		for(var i=0;i<size;i++){
			nodes[i].style.display = "none"
		}
		var AdName = document.getElementById("ad_name").value;
		var destination_url = document.getElementById("destination_url").value;
		//var text_display_url = document.getElementById("display_url").value;
		var ad_facebook_title = document.getElementById("ad_native_title").value;
		var ad_facebook_body = document.getElementById("ad_native_body").value;
		/*var pricing_val = document.getElementById("native_pricing_val").value;
		var Clicks = document.getElementById("native_Clicks").value;
		var CPC = document.getElementById("native_CPC").value;
		var Impressions = document.getElementById("native_Impressions").value;
		var CPM = document.getElementById("native_CPM").value;
		var Cost = document.getElementById("native_Cost").value;
		var CPA = document.getElementById("native_CPA").value;*/
		var Exp = /^[0-9a-zA-Z @!#\$\^%&*()+=\-\[\]\\\';,\.\/\{\}\|\":<>\?]+$/;
		var imageCode = document.getElementById("upload_datafile1").value;
		if(AdName == ''){
			document.getElementById("native_AdNameError").innerHTML = "Please provide Ad name";
			document.getElementById("native_AdNameError").style.display = "inline";
			return false;
		}
		else
		{
			checkAdName(AdName,'native');
		}
		if(destination_url == ''){
			document.getElementById("native_DestUrlError").innerHTML = "Please give a valid URL";
			document.getElementById("native_DestUrlError").style.display = "inline";
			return false;
		} else {
			if(!destination_url.match(/(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/)) {
				document.getElementById("native_DestUrlError").innerHTML = "Please give a valid URL";
				document.getElementById("native_DestUrlError").style.display = "inline";
				return false;
			}
		}
		/*if(text_display_url == ''){
			document.getElementById("native_DisplayUrlError").innerHTML = "Please give a valid URL";
			document.getElementById("native_DisplayUrlError").style.display = "inline";
			return false;
		} else {
			if(!text_display_url.match(/(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/)) {
				document.getElementById("native_DisplayUrlError").innerHTML = "Please give a valid URL";
				document.getElementById("native_DisplayUrlError").style.display = "inline";
				return false;
			}
		}*/
		if(ad_facebook_title == ''){
			document.getElementById("native_HeadLineError").innerHTML = "Please provide a Headline title";
			document.getElementById("native_HeadLineError").style.display = "inline";
			return false;
		} else {
			if(ad_facebook_title.length > 25){
				document.getElementById("native_HeadLineError").innerHTML = "Title cannot be more than more than 25 character length";
				document.getElementById("native_HeadLineError").style.display = "inline";
				return false;
			}
		}
		if(ad_facebook_body == ''){
			document.getElementById("native_TextError").innerHTML = "Please provide some text";
			document.getElementById("native_TextError").style.display = "inline";
			return false;
		} else {
			if(ad_facebook_body.length > 70){
				document.getElementById("native_TextError").innerHTML = "Text cannot be more than more than 70 character length";
				document.getElementById("native_TextError").style.display = "inline";
				return false;
			}
		}
		/*
		if(pricing_val == 'CPC') {
			if(Clicks == ''){
				document.getElementById("native_PricingError").innerHTML = "Clicks cannot be null";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			} else if(isNaN(Clicks)){
				document.getElementById("native_PricingError").innerHTML = "Please give only integer values";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			}
			else if(Clicks < 1 ||  Clicks > 1000)
			{
				document.getElementById("native_PricingError").innerHTML = "Clicks should be in the range 1 to 1000";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			}
			else
			{
				document.getElementById("native_Clicks").value=parseInt(Clicks);
			}
			if(CPC == ''){
				document.getElementById("native_PricingError").innerHTML = "CPC cannot be null";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			} else if(isNaN(CPC)){
				document.getElementById("native_PricingError").innerHTML = "Please give only integer values";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			}
			else
			{
					var n = CPC.toString().split('.');
				  var decimalpoints=['0'];
				  if(n.length >= 2)
				  {
				  	var decimalpoints=n[1];
				  }
					if(decimalpoints.length <= 2)
					{
							if(CPC > 1000)
							{
								document.getElementById("native_PricingError").style.display = 'inline';
						    document.getElementById("native_PricingError").innerHTML = 'Value cannot be more than 1000 !';
						    return false ;
							}
							else
							{
								document.getElementById("native_CPC").value=(parseFloat(document.getElementById("native_CPC").value)).toFixed(2);
								document.getElementById("native_PricingError").style.display = 'none';
						  }
					}
					else
					{
							document.getElementById("native_PricingError").style.display = 'inline';
				      document.getElementById("native_PricingError").innerHTML = 'Please enter only two digits after the decimal point !';
				      return false ;
					}
			}
		}
		if(pricing_val == 'CPM') {
			if(Impressions == ''){
				document.getElementById("native_PricingError").innerHTML = "Impressions cannot be null";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			}  else if(isNaN(Impressions)){
				document.getElementById("native_PricingError").innerHTML = "Please give only integer values";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			}
			else if(Impressions < 1 ||  Impressions > 1000)
			{
				document.getElementById("native_PricingError").innerHTML = "Impressions should be in the range 1 to 1000";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			}
			else{
				document.getElementById("native_Impressions").value=parseInt(Impressions);
			}
			if(CPM == ''){
				document.getElementById("native_PricingError").innerHTML = "CPM cannot be null";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			} else if(isNaN(CPM)){
				document.getElementById("native_PricingError").innerHTML = "Please give only integer values";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			}
			else
			{
					var n = CPM.toString().split('.');
				  var decimalpoints=['0'];
				  if(n.length >= 2)
				  {
				  	var decimalpoints=n[1];
				  }
					if(decimalpoints.length <= 2)
					{
							if(CPM > 1000)
							{
								document.getElementById("native_PricingError").style.display = 'inline';
						    document.getElementById("native_PricingError").innerHTML = 'Value cannot be more than 1000 !';
						    return false ;
							}
							else
							{
								document.getElementById("native_CPM").value=(parseFloat(document.getElementById("native_CPM").value)).toFixed(2);
								document.getElementById("native_PricingError").style.display = 'none';
						  }
					}
					else
					{
							document.getElementById("native_PricingError").style.display = 'inline';
				      document.getElementById("native_PricingError").innerHTML = 'Please enter only two digits after the decimal point !';
				      return false ;
					}
			}
			
		}
		if(pricing_val == 'CPA') {
			if(Cost == ''){
				document.getElementById("native_PricingError").innerHTML = "Conversions cannot be null";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			} else if(isNaN(Cost)){
				document.getElementById("native_PricingError").innerHTML = "Please give only integer values";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			}
			else if(Cost < 1 ||  Cost > 1000)
			{
				document.getElementById("native_PricingError").innerHTML = "Conversions should be in the range 1 to 1000";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			}
			else
			{
				document.getElementById("native_Cost").value=parseInt(Cost);
			}
			if(CPA == ''){
				document.getElementById("native_PricingError").innerHTML = "CPA cannot be null";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			} else if(isNaN(CPA)){
				document.getElementById("native_PricingError").innerHTML = "Please give only integer values";
				document.getElementById("native_PricingError").style.display = "inline";
				return false;
			}
			else
			{
					var n = CPA.toString().split('.');
				  var decimalpoints=['0'];
				  if(n.length >= 2)
				  {
				  	var decimalpoints=n[1];
				  }
					if(decimalpoints.length <= 2)
					{
							if(CPA > 1000)
							{
								document.getElementById("native_PricingError").style.display = 'inline';
						    document.getElementById("native_PricingError").innerHTML = 'Value cannot be more than 1000 !';
						    return false ;
							}
							else
							{
								document.getElementById("native_CPA").value=(parseFloat(document.getElementById("native_CPA").value)).toFixed(2);
								document.getElementById("native_PricingError").style.display = 'none';
						  }
					}
					else
					{
							document.getElementById("native_PricingError").style.display = 'inline';
				      document.getElementById("native_PricingError").innerHTML = 'Please enter only two digits after the decimal point !';
				      return false ;
					}
			}
		}*/
		if(imageCode == ''){
			document.getElementById("native_ImageError").innerHTML = "Please give a valid Image, Please check prefered size.";
			document.getElementById("native_ImageError").style.display = "inline";
			return false;
		}
		if(adExists==false)
		{
			return false ;
		}
		else
		{
			return true ;
		}

	}
	
	var adExists=true;
function checkAdName(adName,type)
{

var hostname = "http://"+window.location.hostname+":3000/ads/checkAdName";
				
					$.ajax({
						type: "GET",
						url: hostname,
						data: "adName=" + adName ,
						success: function(data){
							if(data=="yes")
							{
								if(type=='text')
								{
									document.getElementById("AdNameError").innerHTML="Ad Name already exists!";
       						document.getElementById("AdNameError").style.display="inline";
								}
								else if(type=='native')
								{
								
									document.getElementById("native_AdNameError").innerHTML="Ad Name already exists!";
       						document.getElementById("native_AdNameError").style.display="inline";
								}
								else if(type=='banner')
								{
									document.getElementById("banner_AdNameError").innerHTML="Ad Name already exists!";
       						document.getElementById("banner_AdNameError").style.display="inline";
								}
								adExists=false;
								return false;
							}
							else
							{
								if(type=='text')
								{
       						document.getElementById("AdNameError").style.display="none";
								}
								else if(type=='native')
								{
       						document.getElementById("native_AdNameError").style.display="none";
								}
								else if(type=='banner')
								{
       						document.getElementById("banner_AdNameError").style.display="none";
								}
								adExists=true;
							}
						}
					});
return ;
}
function checkadName(adName,adType) {
	
}

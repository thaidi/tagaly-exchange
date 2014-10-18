//Validation for Styles
function stylesValidation(stylenames) {
	var stylename = (document.getElementById("stylename").value).trim();
	if(stylename.length == 0) {
		document.getElementById("nameerror").style.display = 'block';
		document.getElementById("nameerror").style.marginLeft = "3px";
		document.getElementById("nameerror").innerHTML = 'Name field cannot be blank';
		return false;
	} else {
		if(stylenames.indexOf(stylename) != -1) {
			document.getElementById("nameerror").style.display = 'block';
			document.getElementById("nameerror").style.marginLeft = "3px";
			document.getElementById("nameerror").innerHTML = 'Name already exists';
			return false;
		}
	}
}

// Validation for Publisher Sites 
function placementsValidation(placementnames) {
	var placmentname = (document.getElementById("placmentname").value).trim();
	if(placmentname.length == 0) {
		document.getElementById("nameerror").style.display = 'block';
		document.getElementById("nameerror").style.marginLeft = "3px";
		document.getElementById("nameerror").innerHTML = 'Name field cannot be blank';
		return false;
	} else {		
		if(placementnames.indexOf(placmentname) != -1) {
			document.getElementById("nameerror").style.display = 'block';
			document.getElementById("nameerror").style.marginLeft = "3px";
			document.getElementById("nameerror").innerHTML = 'Name already exists';
			return false;
		}
	}
}

var validURL=0;
// Validation for Publisher Sites 
function publisherSitesValidation(allSites,allNames) {
			nodes = document.getElementsByClassName("error");
			nodes[0].style.display = "none"
			nodes[1].style.display = "none"
			nodes[2].style.display = "none"
			nodes[3].style.display = "none"
			nodes[4].style.display = "none"
			nodes[5].style.display = "none"
			var website_title = (document.getElementById("website_title").value).trim();
			if(website_title.length == 0){
				document.getElementById("titleerror").style.display = 'block';
				document.getElementById("titleerror").innerHTML = 'Title field cannot be blank';
				return false;
			} else {
				if ($.inArray(website_title, allNames) !== -1){
					document.getElementById("titleerror").style.display = 'block';
					document.getElementById("titleerror").innerHTML = 'Site name already exists';
					return false;
				}
			}
			var website_url = document.getElementById("website_url").value;
			if(website_url.length == 0){
				document.getElementById("URLerror").style.display = 'block';
				document.getElementById("URLerror").innerHTML = 'Please give valid url';
				return false;
			} else {
				if ($.inArray(website_url, allSites) !== -1){
					document.getElementById("URLerror").style.display = 'block';
					document.getElementById("URLerror").innerHTML = 'Site already exists';
					return false;
				}
				var re = /^(http[s]?:\/\/){0,1}(www\.){0,1}[a-zA-Z0-9\.\-]+\.[a-zA-Z]{2,5}[\.]{0,1}/;
				if (!re.test(website_url)) { 
					document.getElementById("URLerror").style.display = 'block';
					document.getElementById("URLerror").innerHTML = 'Please give valid url';
					return false;
				} else {
						if(website_url.indexOf("http://") != -1 || website_url.indexOf("https://") != -1)
						{
						} else {
							document.getElementById("URLerror").style.display = 'block';
							document.getElementById("URLerror").innerHTML = 'Please give valid url';
							return false;  
						}
				}
			}
			var description = (document.getElementById("description").value).trim();
			if(description.length == 0){
				document.getElementById("descerror").style.display = 'block';
				document.getElementById("descerror").innerHTML = 'Please give description';
				return false;
			}
			var publishersite_channel = document.getElementById("publishersite_channel").value;
			if(parseInt(publishersite_channel) == 0){
				document.getElementById("channelerror").style.display = 'block';
				document.getElementById("channelerror").innerHTML = 'Please select any channel';
				return false;
			}
			var publishersite_language = document.getElementById("publishersite_language").value;
			if(parseInt(publishersite_language) == 0){
				document.getElementById("languageeerror").innerHTML = "Please select any language";
				document.getElementById("languageeerror").style.display = "block";
				return false;
			}
			var avg_mon_imps = (document.getElementById("avg_mon_imps").value).trim();
			if(avg_mon_imps.length != 0){
				if(isNaN(avg_mon_imps)){
					document.getElementById("impressionseerror").innerHTML = "Please give only numbers";
					document.getElementById("impressionseerror").style.display = "block";
					return false;
				} else {
					if(avg_mon_imps < 0){
						document.getElementById("impressionseerror").innerHTML = "Please give only positive numbers";
						document.getElementById("impressionseerror").style.display = "block";
						return false;
					}
				}
			} else {
				document.getElementById("impressionseerror").innerHTML = "Field cannot be blank";
				document.getElementById("impressionseerror").style.display = "block";
				return false;
			}
		sitename = document.getElementById("website_title").value
		funvalidateName(sitename);
		if(validName == 0)
		{
			return false ;
		}
		funvalidateUrl(website_url);
		if(validURL != 0 && validName != 0 )
		{
			return true ;
		}
		else
		{
			return false;
		}
}

function funvalidateUrl(siteurl) {
  var hostname=window.location.hostname;
  if (window.XMLHttpRequest) {
		xmlhttp=new XMLHttpRequest();
  } else {
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
  xmlhttp.onreadystatechange=function()
  { 
		if (xmlhttp.readyState==4 && xmlhttp.status==200) {
			if(xmlhttp.responseText=="0") {
				document.getElementById("URLerror").style.display="none";
				validURL=1;
			} else if(xmlhttp.responseText=="1") {
				document.getElementById("URLerror").style.display="block";
				document.getElementById("URLerror").innerHTML="Site already exists!";
				validURL=0;
			}
			return xmlhttp.responseText ;
		}
	}

	if(document.getElementById("edit").value=='yes') {
		var siteId=document.getElementById("siteId").value;
		xmlhttp.open("GET","http://"+hostname+":3000/publishersites/checkURL?siteurl="+siteurl+"&siteId="+siteId,true);
	} else {
		xmlhttp.open("GET","http://"+hostname+":3000/publishersites/checkURL?siteurl="+siteurl,true);
	}
	/*
		xmlhttp.open("GET","http://"+hostname+":3000/publishersites/checkURL?siteurl="+siteurl,true);
	*/
	xmlhttp.send();
}


function funvalidateName(sitename) {
		
		      var hostname=window.location.hostname;
		      if (window.XMLHttpRequest)
		      {// code for IE7+, Firefox, Chrome, Opera, Safari
			  xmlhttp=new XMLHttpRequest();
		      }
		      else
		      {// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		      }
		      xmlhttp.onreadystatechange=function()
		      {
		      if (xmlhttp.readyState==4 && xmlhttp.status==200)
		      {
						if(xmlhttp.responseText=="0")
						{
							document.getElementById("titleerror").style.display="none";
							validName=1;
						}
						else if(xmlhttp.responseText=="1")
						{
								document.getElementById("titleerror").style.display="block";
								document.getElementById("titleerror").innerHTML="Site name already exists!";
								 		  validName=0;
						}
						return xmlhttp.responseText ;
			}
			}
			if(document.getElementById("edit").value=='yes')
		{
			var siteId=document.getElementById("siteId").value;
			xmlhttp.open("GET","http://"+hostname+":3000/publishersites/checkSiteName?sitename="+sitename+"&siteId="+siteId,true);
		}
		else
		{
			xmlhttp.open("GET","http://"+hostname+":3000/publishersites/checkSiteName?sitename="+sitename,true);
		}
			
			xmlhttp.send();
}
function nativeadunitValidation(adunitsname) {

	var adunitname = (document.getElementById("nativeadunitname").value).trim();
	var adunitdescription = (document.getElementById("nativeadunitdescription").value).trim();
	// var backupads = (document.getElementById("backupads").value).trim();
	// var adunitbackupads = (document.getElementById("adunitbackupads").value).trim();
	// var adunitfullbackground = (document.getElementById("adunitfullbackground").value).trim();
	// var adunitdevice = (document.getElementById("adunitdevice").value).trim();
	var adunitTempFormat = (document.getElementById("tempFormat").value).trim();
	var imgFormat = (document.getElementById("imgFormat").value).trim();
	var nativeadunitstyleid = (document.getElementById("nativeadunittypesel").value).trim();
	// var pricing_val = (document.getElementById("N-pricing_val").value).trim();
	var CPC = (document.getElementById("native_CPC").value).trim();
	var CPM = (document.getElementById("native_CPM").value).trim();
	var CPA = (document.getElementById("native_CPA").value).trim();
  var nativeAdTempWidth = (document.getElementById("nativeAdTempWidth").value).trim();
  var nativeAdTempHeight = (document.getElementById("nativeAdTempHeight").value).trim();
  var nativeAdImgWidth = (document.getElementById("nativeAdImgWidth").value).trim();
  var nativeAdImgHeight = (document.getElementById("nativeAdImgHeight").value).trim();
	var checkboxstatus = 0;
	var checkboxCpcStatus = 0;
	var checkboxCpmStatus = 0;
	var checkboxCpaStatus = 0;
	if (document.getElementById('native_checkboxCpc').checked){
		checkboxstatus = 1;
	 	checkboxCpcStatus = 1;
	}
	if (document.getElementById('native_checkboxCpm').checked){
		checkboxstatus = 1;
	 	checkboxCpmStatus = 1;
	}
	if (document.getElementById('native_checkboxCpa').checked){
		checkboxstatus =1
	 	checkboxCpaStatus = 1;
	}
	if(adunitname == ''){
		document.getElementById("nativenameerror").style.display = 'block';
		document.getElementById("nativenameerror").innerHTML = 'Name Field cannot be blank';
		return false;
	} else {
		if(adunitsname.indexOf(adunitname) != -1) {
			document.getElementById("nativenameerror").style.display = 'block';
			document.getElementById("nativenameerror").innerHTML = 'Name already exists';
			return false;
		}
	}
	if(adunitdescription == ''){
		document.getElementById("nativedescriptionerror").style.display = 'block';
		document.getElementById("nativedescriptionerror").innerHTML = 'Description Field cannot be blank';
		return false;
	}
	if(nativeadunitstyleid == ''){
		document.getElementById("nativestyleiderror").style.display = 'block';
		document.getElementById("nativestyleiderror").innerHTML = 'Select any style or create a new style';
		return false;
	}
	if(checkboxstatus == 0){
		document.getElementById("N-PricingError").style.display = 'block';
		document.getElementById("N-PricingError").innerHTML = 'Select atleast one pricing metric';
		return false;
	}
		if(checkboxCpcStatus == 1) {
			if(CPC == ''){
				document.getElementById("N-PricingError").innerHTML = "CPC cannot be null";
				document.getElementById("N-PricingError").style.display = "inline";
				return false;
			} else if(isNaN(CPC)){
				document.getElementById("N-PricingError").innerHTML = "Please give only integer values";
				document.getElementById("N-PricingError").style.display = "inline";
				return false;
			} else if (CPC < 0){
				document.getElementById("N-PricingError").innerHTML = "Please give only positive integer values";
				document.getElementById("N-PricingError").style.display = "inline";
				return false;
			} 
			else if(CPC > 1000){
				document.getElementById("PricingError").innerHTML = "CPC should be below $1000";
				document.getElementById("PricingError").style.display = "inline";
				return false;
			}
		}
		if(checkboxCpmStatus == 1) {
			if(CPM == ''){
				document.getElementById("N-PricingError").innerHTML = "CPM cannot be null";
				document.getElementById("N-PricingError").style.display = "inline";
				return false;
			} else if(isNaN(CPM)){
				document.getElementById("N-PricingError").innerHTML = "Please give only integer values";
				document.getElementById("N-PricingError").style.display = "inline";
				return false;
			} else if (CPM < 0){
				document.getElementById("N-PricingError").innerHTML = "Please give only positive integer values";
				document.getElementById("N-PricingError").style.display = "inline";
				return false;
			} 
			else if(CPM > 1000){
				document.getElementById("N-PricingError").innerHTML = "CPM should be below $1000";
				document.getElementById("N-PricingError").style.display = "inline";
				return false;
			}
		}
		if(checkboxCpaStatus == 1) {
			if(CPA == ''){
				document.getElementById("N-PricingError").innerHTML = "CPA cannot be null";
				document.getElementById("N-PricingError").style.display = "inline";
				return false;
			} else if(isNaN(CPA)){
				document.getElementById("N-PricingError").innerHTML = "Please give only integer values";
				document.getElementById("N-PricingError").style.display = "inline";
				return false;
			} else if (CPA < 0){
				document.getElementById("N-PricingError").innerHTML = "Please give only positive integer values";
				document.getElementById("N-PricingError").style.display = "inline";
				return false;
			} 
			else if(CPA > 1000){
				document.getElementById("N-PricingError").innerHTML = "CPA should be below $1000";
				document.getElementById("N-PricingError").style.display = "inline";
				return false;
			}
		}
	if(adunitTempFormat == ""){
		document.getElementById("TempError").innerHTML = "Select any template size";
		document.getElementById("TempError").style.display = "inline";
		return false;
	} else if(adunitTempFormat == "Create") {
		if(nativeAdTempWidth == ""){
			document.getElementById("TempError").innerHTML = "Template width cannot be null";
			document.getElementById("TempError").style.display = "inline";
			return false;
		} else if(isNaN(nativeAdTempWidth)){
			document.getElementById("TempError").innerHTML = "Template width should be only integer values";
			document.getElementById("TempError").style.display = "inline";
			return false;
		}
		if(nativeAdTempHeight == ""){
			document.getElementById("TempError").innerHTML = "Template height cannot be null";
			document.getElementById("TempError").style.display = "inline";
			return false;
		} else if(isNaN(nativeAdTempHeight)){
			document.getElementById("TempError").innerHTML = "Template height should be only integer values";
			document.getElementById("TempError").style.display = "inline";
			return false;
		}
		if(nativeAdImgWidth == ""){
			document.getElementById("ImgError").innerHTML = "Image width cannot be null";
			document.getElementById("ImgError").style.display = "inline";
			return false;
		} else if(isNaN(nativeAdImgWidth)){
			document.getElementById("ImgError").innerHTML = "Image width should be only integer values";
			document.getElementById("ImgError").style.display = "inline";
			return false;
		}
		if(nativeAdImgHeight == ""){
			document.getElementById("ImgError").innerHTML = "Image height cannot be null";
			document.getElementById("ImgError").style.display = "inline";
			return false;
		} else if(isNaN(nativeAdImgHeight)){
			document.getElementById("ImgError").innerHTML = "Image height should be only integer values";
			document.getElementById("ImgError").style.display = "inline";
			return false;
		}
	} else {
		if (imgFormat == "" ){
			document.getElementById("ImgError").innerHTML = "Select any Image format";
			document.getElementById("ImgError").style.display = "inline";
			return false;
		}
	}
}
function adunitValidation(adunitsnames) {
	var adunitname = (document.getElementById("adunitname").value).trim();
	var adunitdescription = (document.getElementById("adunitdescription").value).trim();
	var backupads = (document.getElementById("backupads").value).trim();
	var adunitbackupads = (document.getElementById("adunitbackupads").value).trim();
	var adunitfullbackground = (document.getElementById("adunitfullbackground").value).trim();
	var adunittype = (document.getElementById("adunittype").value).trim();
	var adunitformat = (document.getElementById("adunitformat").value).trim();
	var adunittypesel = (document.getElementById("adunittypesel").value).trim();
	var CPC = (document.getElementById("eCpm").value).trim();
	var adunitPlacementId = document.getElementById('adunitPlacementId');
	var v = 0;
	for(i=0;i<adunitPlacementId.length;i++){
		if(adunitPlacementId.options[i].selected){
			v = 1; break;
		}
	}
	if(adunitname == ''){
		document.getElementById("nameerror").style.display = 'block';
		document.getElementById("nameerror").innerHTML = 'Name Field cannot be blank';
		return false;
	} else {
		if(adunitsnames.indexOf(adunitname) != -1) {
			document.getElementById("nameerror").style.display = 'block';
			document.getElementById("nameerror").style.marginLeft = "3px";
			document.getElementById("nameerror").innerHTML = 'Name already exists';
			return false;
		}
	}
	if(adunitdescription == ''){
		document.getElementById("descriptionerror").style.display = 'block';
		document.getElementById("descriptionerror").innerHTML = 'Description Field cannot be blank';
		return false;
	}
	if(backupads == 'anotherURL'){
		if(adunitbackupads == ''){
			document.getElementById("alternateerror").style.display = 'block';
			document.getElementById("alternateerror").innerHTML = 'Alternate URL Field cannot be blank';
			return false;
		}
		var re = /^(http[s]?:\/\/){0,1}(www\.){0,1}[a-zA-Z0-9\.\-]+\.[a-zA-Z]{2,5}[\.]{0,1}/;
		url = adunitbackupads
		if (!re.test(url)) { 
				document.getElementById("alternateerror").style.display = 'block';
				document.getElementById("alternateerror").innerHTML = 'Please give a valid URL';
				return false;
		} else {
				if(url.indexOf("http://") == -1){
					document.getElementById("alternateerror").style.display = 'block';
					document.getElementById("alternateerror").innerHTML = 'Please give a valid URL';
					return false;
				}
		}
	}
	if(backupads == 'FillSpace'){
		if(adunitfullbackground == ''){
			document.getElementById("fullbackgrounderror").style.display = 'block';
			document.getElementById("fullbackgrounderror").innerHTML = 'Background Field cannot be blank';
			return false;
		}
	}
	if(adunittypesel == ''){
		document.getElementById("styleiderror").style.display = 'block';
		document.getElementById("styleiderror").innerHTML = 'Select any style type';
		return false;
	}
	if(adunittypesel == 'new'){
		document.getElementById("styleiderror").style.display = 'block';
		document.getElementById("styleiderror").innerHTML = 'Create a style';
		return false;
	}
	if(v == 0){
		document.getElementById("placementerror").style.display = 'block';
		document.getElementById("placementerror").innerHTML = 'Select atleast one placement';
		return false;
	}
	if(CPC == ''){
		document.getElementById("PricingError").innerHTML = "CPC cannot be null";
		document.getElementById("PricingError").style.display = "inline";
		return false;
	} else if(isNaN(CPC)){
		document.getElementById("PricingError").innerHTML = "Please give only integer values";
		document.getElementById("PricingError").style.display = "inline";
		return false;
	} else if (CPC < 0){
		document.getElementById("PricingError").innerHTML = "Please give only positive integer values";
		document.getElementById("PricingError").style.display = "inline";
		return false;
	} else if(CPC > 1000){
		document.getElementById("PricingError").innerHTML = "CPC should be below $1000";
		document.getElementById("PricingError").style.display = "inline";
		return false;
	}
}


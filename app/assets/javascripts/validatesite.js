validURL=0
function validateSiteFields()
{
	var validatedsitename=0;
	var validatedsiteurl=0;
	var validatedsitedesc=0;
	var urlregexp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/
	if(document.getElementById("sitename").value.trim() == "")
	{
		document.getElementById("sitenameerror").innerHTML="Please fill in the site name !";
		document.getElementById("sitenameerror").style.display="block";
		validatedsitename=0 ;
		return false;
		
	}
	else
	{
		document.getElementById("sitenameerror").style.display="none";
		validatedsitename=1 ;
	}
	if(document.getElementById("siteurl").value.trim() == "")
	{
		document.getElementById("siteurlerror").innerHTML="Please fill in the site url !";
		document.getElementById("siteurlerror").style.display="block";
		validatedsiteurl=0 ;
		return false;
		
	}
	else if(urlregexp.test(document.getElementById("siteurl").value)==false)
	{
		validatedsiteurl= 0;
		document.getElementById("siteurlerror").style.display="block";
		document.getElementById("siteurlerror").innerHTML="Please enter valid URL";
		return false;
	
	}
	else
	{
		document.getElementById("siteurlerror").style.display="none";
	}
	if(document.getElementById("description").value.trim() == "")
	{
		document.getElementById("sitedescerror").innerHTML="Please fill in the site description !";
		document.getElementById("sitedescerror").style.display="block";
		validatedsitedesc=0 ;
		return false;
		
	}
	else
	{
		document.getElementById("sitedescerror").style.display="none";
		validatedsitedesc= 1;
	}
	  sitename = document.getElementById("sitename").value
		funvalidateName(sitename);
		if(validName == 0)
		{
			return false ;
		}
		siteurl = document.getElementById("siteurl").value ;
		funvalidateUrl(siteurl);
		if(validURL != 0 && validName != 0 )
		{
			return true ;
		}
		else
		{
			return false;
		}
		// console.log(validateUrl)
		// if(validateUrl){ return true;	} else { return false; }
}

function funvalidateUrl(siteurl) {
		/*$.ajax({
				type: 'HEAD',
				url: siteurl,
				success: function(){
					// return true ;
					document.getElementById("siteurlerror").style.display="none";
					validURL=1;
				},
				error: function() {
					document.getElementById("siteurlerror").style.display="block";
					document.getElementById("siteurlerror").innerHTML="Url is broken, Please enter valid URL";
					validURL=0; ;
				}
			});*/
			
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
		      //alert(xmlhttp.responseText);
			if(xmlhttp.responseText=="0")
			{
				document.getElementById("siteurlerror").style.display="none";
				validURL=1;
			}
			else if(xmlhttp.responseText=="1")
			{
				  document.getElementById("siteurlerror").style.display="block";
		      document.getElementById("siteurlerror").innerHTML="Site already exists!";
		       		  validURL=0;
			}
			return xmlhttp.responseText ;
			}
			}
		if(document.getElementById("edit").value=='yes')
		{
			var siteId=document.getElementById("siteId").value;
			xmlhttp.open("GET","http://"+hostname+":3000/sites/checkURL?siteurl="+siteurl+"&edit=edit&siteId="+siteId,true);
		}
		else
		{
			xmlhttp.open("GET","http://"+hostname+":3000/sites/checkURL?siteurl="+siteurl,true);
		}
			xmlhttp.send();
}

function funvalidateName(sitename) {
		/*$.ajax({
				type: 'HEAD',
				url: siteurl,
				success: function(){
					// return true ;
					document.getElementById("siteurlerror").style.display="none";
					validURL=1;
				},
				error: function() {
					document.getElementById("siteurlerror").style.display="block";
					document.getElementById("siteurlerror").innerHTML="Url is broken, Please enter valid URL";
					validURL=0; ;
				}
			});*/
			
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
		      //alert(xmlhttp.responseText);
			if(xmlhttp.responseText=="0")
			{
				document.getElementById("sitenameerror").style.display="none";
				validName=1;
			}
			else if(xmlhttp.responseText=="1")
			{
				  document.getElementById("sitenameerror").style.display="block";
		      document.getElementById("sitenameerror").innerHTML="Site name already exists!";
		       		  validName=0;
			}
			return xmlhttp.responseText ;
			}
			}
			if(document.getElementById("edit").value=='yes')
		{
			var siteId=document.getElementById("siteId").value;
			xmlhttp.open("GET","http://"+hostname+":3000/sites/checkSiteName?sitename="+sitename+"&edit=edit&siteId="+siteId,true);
		}
		else
		{
			xmlhttp.open("GET","http://"+hostname+":3000/sites/checkSiteName?sitename="+sitename,true);
		}
			xmlhttp.send();
}

var retargetExists=true;
function validateForm()
{
	var validatelistname=0;
	var validateduration=0;
	var validatertype=0;
	if(document.getElementById("listname").value.trim()=="")
	{
		document.getElementById("retargetnameerror").style.display="block";
		document.getElementById("retargetnameerror").style.marginLeft="24px";
		document.getElementById("retargetnameerror").innerHTML="Please fill in the retarget name!";
		validatelistname=0; ;
	}
	else
	{
		validatelistname=1;
		document.getElementById("retargetnameerror").style.display="none";
		
			
	}
	if(document.getElementById("duration").value.trim()=="")
	{
		document.getElementById("durationerror").style.display="block";
		document.getElementById("durationerror").style.marginLeft="23px";
		document.getElementById("durationerror").innerHTML="Please fill in the duration!";
		validateduration=0; 
	}
	else if(isNaN(document.getElementById("duration").value))
	{
		document.getElementById("durationerror").style.display="block";
		document.getElementById("durationerror").style.marginLeft="23px";
		document.getElementById("durationerror").innerHTML="Duration should be a valid number!";
		validateduration=0; 
	}
	else if(document.getElementById("duration").value > 10000)
		{
		document.getElementById("durationerror").style.display="block";
		document.getElementById("durationerror").style.marginLeft="23px";
		document.getElementById("durationerror").innerHTML="Duration value should be  below 10000";
		}
	else
	{
		document.getElementById("durationerror").style.display="none";
		validateduration=1;	
	}
	var pattern=/^\/[a-z0-9]*_*-*.*\**$/i ;
	var querypattern=/^[a-z0-9\/&=_]*$/i ;
	if(document.getElementById("retarget_retargeting_type_path").checked==true)
		{
			if(document.getElementById("path_value").value.trim() =="")
				{
					document.getElementById("patherror").style.display="block";
					document.getElementById("patherror").innerHTML="Please fill in the path";
					validatertype=0;
				}
			else
			{
				if(document.getElementById("path_value").value.indexOf(' ') >= 0)
				{
					document.getElementById("patherror").style.display="block";
					document.getElementById("patherror").innerHTML="Path cannot contain a space";
					validatertype=0;
				}
			//alert(document.getElementById("path_value").value);
				else if(pattern.test(document.getElementById("path_value").value)==true)
				{
					validatertype=1;;
					document.getElementById("patherror").style.display="none";
				}
				else
				{
					document.getElementById("patherror").style.display="block";
					document.getElementById("patherror").innerHTML="Please fix in the path";
					validatertype=0;
				}
				
			}

		 }
		 if(document.getElementById("retarget_retargeting_type_query").checked==true)
		{
			if(document.getElementById("queryvalue").value.trim() =="")
			{
				document.getElementById("queryerror").style.display="block";
				document.getElementById("queryerror").innerHTML="Please fill in the Querystring";
				validatertype=0;
			}
			else if(document.getElementById("queryvalue").value.indexOf(' ') >= 0)
			{
					document.getElementById("queryerror").style.display="block";
					document.getElementById("queryerror").innerHTML="Querystring cannot contain a space";
					validatertype=0;
			}
			else
			{
				validatertype=1;
							
			}
		}
		if(document.getElementById("retarget_retargeting_type_regex").checked==true)
		{
			if(document.getElementById("regexp").value.trim() =="")
			{
				document.getElementById("regexerror").style.display="block";
				document.getElementById("regexerror").innerHTML="Please fill in the regular expression!";
				validatertype=0;
			}
			else if(document.getElementById("regexp").value.indexOf(' ') >= 0)
			{
				document.getElementById("regexerror").style.display="block";
				document.getElementById("regexerror").innerHTML="Regular expression cannot contain a space";
				validatertype=0;
			}
			else
			{
			  var isValid;
				try { 
						new RegExp(document.getElementById("regexp").value);
						isValid = true;
				}
				catch(e) {
						isValid = false;
				}

				if (!isValid)
				{
					document.getElementById("regexerror").style.display="block";
					document.getElementById("regexerror").innerHTML="Please provide a valid regular expression!";
					validatertype=0;
				}
				else
				{
					validatertype=1;
					document.getElementById("regexerror").style.display="none";
				}
				
			}
		 }
		 
		
		 if(validateduration==0 || validatelistname==0 || validatertype==0)
		 {
		 	return false;
		 }
		 else
		 {
				// checkRetargetName();
				if(retargetExists==false)
				{
					return false;
				}
				else
				{
					document.forms[0].submit();
				}
				
		 	
		 }
}
function checkRetargetName()
{
str=document.getElementById("listname").value;
var hostname = "http://"+window.location.hostname+":3000/retargets/checklistnameavl";
				
					$.ajax({
						type: "GET",
						url: hostname,
						data: "q="+str ,
						success: function(data){
						
							if(data.trim()!="OK" && document.getElementById("retargetoldName").value != str)
					  	{
					  		document.getElementById("retargetnameerror").style.display="block";
								document.getElementById("retargetnameerror").innerHTML="Retarget name already exists!";
								retargetExists=false
					  		//return true;
					  		//document.forms[0].submit();
					  	}
					  	else
					  	{
					  	
					  		document.getElementById("retargetnameerror").style.display="none";
					  		retargetExists=true;
					  		
					  		
						//return false;
					  	
					  	}
						}
					});
return ;








/*

		 		var xmlhttp;  
		 	var validatelistname;
			   str=document.getElementById("listname").value;
			if (str=="")
			  {
			  document.getElementById("txtHint").innerHTML="";
			  return;
			  }
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
			    alert(xmlhttp.responseText);
			    	//document.getElementById("waitmsg").style.display="none";
			    	if(xmlhttp.responseText.trim()=="OK")
			    	{
			    		document.getElementById("retargetnameerror").style.display="none";
			    		validatelistname=1;
			    		//return true;
			    		//document.forms[0].submit();
			    	}
			    	else
			    	{
			    		document.getElementById("retargetnameerror").style.display="block";
					document.getElementById("retargetnameerror").innerHTML="Retarget name already exists!";
					validatelistname=0; ;
					alert(validatelistname);
					//return false;
			    	
			    	}
			    }
			  }
			 var hostname=window.location.hostname;
			xmlhttp.open("GET","http://"+hostname+":3000/retargets/checklistnameavl?q="+str,true);
			xmlhttp.send();
			return validatelistname ;
			//return false ;*/
}

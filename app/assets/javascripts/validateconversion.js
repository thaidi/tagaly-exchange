var conversionExists=false;
function validateEditForm() {
	var validatelistname=0;
	var validaterevenue=0;
	if(document.getElementById("con_name").value.trim()=="") {
		document.getElementById("conversionnameerror").style.display="block";
		document.getElementById("conversionnameerror").innerHTML="Please fill in the conversion name!";
		validatelistname=0; ;
	} else {
		validatelistname=1;
		document.getElementById("conversionnameerror").style.display="none";
	}
	if(document.getElementById("revenue").value.trim()=="") {
		document.getElementById("revenueerror").style.display="block";
		document.getElementById("revenueerror").innerHTML="Please fill in the revenue!";
		validaterevenue=0; 
	}
	else if(isNaN(document.getElementById("revenue").value)) {
		document.getElementById("revenueerror").style.display="block";
		document.getElementById("revenueerror").innerHTML="Revenue should be a valid number!";
		validaterevenue=0; 
	} else {
	     var n = document.getElementById("revenue").value.toString().split('.');
    	  var decimalpoints=['0'];
		    if(n.length >= 2) {
		    	var decimalpoints=n[1];
		    }
				if(decimalpoints.length <= 2) {
					document.getElementById("revenue").value=parseFloat(document.getElementById("revenue").value).toFixed(2);
						document.getElementById("revenueerror").style.display="none";
						validaterevenue=1;
				} else {
						document.getElementById("revenueerror").style.display = 'block';
		        document.getElementById("revenueerror").innerHTML = 'Please enter only two digits after the decimal point !';
		        validaterevenue=0 ;
				}
	}
	if(validaterevenue==0 || validatelistname==0 || validatectype==0) {
		return false;
	} else {
		checkConversionName();
		if(conversionExists==false) {
			return false;
		} else {
			document.forms[0].submit();
		}
	}
}
function validateForm()
{
	var validatelistname=0;
	var validaterevenue=0;
	var validatectype=0;
	if(document.getElementById("con_name").value.trim()=="")
	{
		document.getElementById("conversionnameerror").style.display="block";
		document.getElementById("conversionnameerror").innerHTML="Please fill in the conversion name!";
		validatelistname=0; ;
	}
	else
	{
		validatelistname=1;
		document.getElementById("conversionnameerror").style.display="none";
		
			
	}
	if(document.getElementById("revenue").value.trim()=="")
	{
		document.getElementById("revenueerror").style.display="block";
		document.getElementById("revenueerror").innerHTML="Please fill in the revenue!";
		validaterevenue=0; 
	}
	else if(isNaN(document.getElementById("revenue").value))
	{
		document.getElementById("revenueerror").style.display="block";
		document.getElementById("revenueerror").innerHTML="Revenue should be a valid number!";
		validaterevenue=0; 
	}
	else
	{
	     var n = document.getElementById("revenue").value.toString().split('.');
    	  var decimalpoints=['0'];
		    if(n.length >= 2)
		    {
		    	var decimalpoints=n[1];
		    }
				if(decimalpoints.length <= 2)
				{
					document.getElementById("revenue").value=parseFloat(document.getElementById("revenue").value).toFixed(2);
						document.getElementById("revenueerror").style.display="none";
						validaterevenue=1;
				}
				else
				{
						document.getElementById("revenueerror").style.display = 'block';
		        document.getElementById("revenueerror").innerHTML = 'Please enter only two digits after the decimal point !';
		        validaterevenue=0 ;
				}
			
	}
	var pattern=/^\/[a-z0-9]*_*-*.*\**$/i ;
	if(document.getElementById("conversion_conversionType_path").checked==true)
		{
			if(document.getElementById("path_value").value != "")
			{
			//alert(document.getElementById("path_value").value);
				if(pattern.test(document.getElementById("path_value").value)==true)
				{
					validatectype=1;;
					document.getElementById("patherror").style.display="none";
				}
				else
				{
					document.getElementById("patherror").style.display="block";
					document.getElementById("patherror").innerHTML="Please fix in the path";
					validatectype=0;
				}
				
			}
			else 
			{
			
				if(document.getElementById("path_value").value.trim() =="")
				{
					document.getElementById("patherror").style.display="block";
					document.getElementById("patherror").innerHTML="Please fill in the path";
					validatectype=0;
				}
			}
		 }
		 if(document.getElementById("conversion_conversionType_query").checked==true)
		{
			if(document.getElementById("queryvalue").value.trim() =="")
			{
				document.getElementById("queryerror").style.display="block";
				document.getElementById("queryerror").innerHTML="Please fill in the query";
				validatectype=0;
			}
			else
			{
				validatectype=1;
				document.getElementById("queryerror").style.display="none";
			}
		}
		if(document.getElementById("conversion_conversionType_regex").checked==true)
		{
			if(document.getElementById("regexp").value.trim() =="")
			{
				document.getElementById("regexerror").style.display="block";
				document.getElementById("regexerror").innerHTML="Please fill in the regular expression!";
				validatectype=0;
			}
			else
			{
				validatectype=1;
				document.getElementById("regexerror").style.display="none";
			}
		 }
		 
		
		 if(validaterevenue==0 || validatelistname==0 || validatectype==0)
		 {
		 	return false;
		 }
		 else
		 {
         		checkConversionName();
				if(conversionExists==false)
				{
					return false;
				}
				else
				{
					document.forms[0].submit();
				}
		 	
		 }
}
function checkConversionName()
{
str=document.getElementById("con_name").value;
var hostname = "http://"+window.location.hostname+":3000/conversions/checklistnameavl";
				
					$.ajax({
						type: "GET",
						url: hostname,
						data: "q="+str ,
						success: function(data){
						//alert(data);
							if(data.trim()!="OK" && document.getElementById("conversionoldName").value != str)
					  	{
					  		document.getElementById("conversionnameerror").style.display="-moz-stack";
								document.getElementById("conversionnameerror").innerHTML="Conversion name already exists!";
								conversionExists=false
					  		//return true;
					  		//document.forms[0].submit();
					  	}
					  	else
					  	{
					  	
					  		document.getElementById("conversionnameerror").style.display="none";
					  		conversionExists=true;
					  		
					  		
						//return false;
					  	
					  	}
						}
					});
return ;
}

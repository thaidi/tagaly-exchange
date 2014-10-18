//Ajax Validations
$(document).ready(function(){
	//First Name validation
	$("#firstname").change(function(){
	if($("#firstname").val().trim() == "")
     {
         document.getElementById("fnameerror").style.display="block";
         document.getElementById("fnameerror").innerHTML="Please fill in the First Name!";
         return false;
     }
     else
     {
         document.getElementById("fnameerror").style.display="none";
     }
	});
	//Last Name Validation
	$("#lastname").change(function(){
	if($("#lastname").val().trim() == "")
     {
         document.getElementById("lnameerror").style.display="block";
         document.getElementById("lnameerror").innerHTML="Please fill in the Last Name!";
         return false;
     }
     else
     {
         document.getElementById("lnameerror").style.display="none";
     }
	});
	//Workemail
	$("#workemail").change(function(){
		if($("#workemail").val().trim() == "")
     {
         document.getElementById("workemailerror").style.display="block";
         document.getElementById("workemailerror").innerHTML="Please fill in the work email!";
     }
     else
     {
         var x=$("#workemail").val();
        var atpos=x.indexOf("@");
        var dotpos=x.lastIndexOf(".");
        if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length)
          {
              document.getElementById("workemailerror").style.display="block";
               document.getElementById("workemailerror").innerHTML="Please enter a valid work email!";
          }
          else
          {
              document.getElementById("workemailerror").style.display="none";
              checkEmail(x);
          }
     		}
     });
     //Password validation
     $("#pwd").change(function(){
     	if($("#pwd").val().trim() == "")
		   {
		       document.getElementById("pwderror").style.display="block";
		       document.getElementById("pwderror").innerHTML="Please fill in the password!";
		   }
		   else
		   {
		       document.getElementById("pwderror").style.display="none";
		   }
     });
     //Confirm Password
     $("#cpwd").change(function(){
     	if(document.getElementById("cpwd").value.trim() == "")
		   {
		       document.getElementById("cpwderror").style.display="block";
		       document.getElementById("cpwderror").innerHTML="Please confirm your password !";
		   }
		   else
		   {
	 
		       if (document.getElementById('cpwd').value != document.getElementById('pwd').value) {
		           document.getElementById("cpwderror").style.display="block";
		           document.getElementById("cpwderror").innerHTML="Confirm password should match the password!";
		       } else {
		           document.getElementById("cpwderror").style.display="none";
		       }
		   }
     });
     
     // Time zone validation
     $("#user_userTimezone").change(function(){
		   if(document.getElementById("user_userTimezone").value.trim() == "")
		   {
		       document.getElementById("timezoneerror").style.display="block";
		       document.getElementById("timezoneerror").innerHTML="Please select your timezone!";
		   }
		   else
		   {
		       document.getElementById("timezoneerror").style.display="none";
		  
		   }
     });
});



emailExists=0;
 function check()
 {
     var validateemail = validatepwd= validateutype = validatefname= validatelname = validatetimezone = 1;
     if(document.getElementById("workemail").value.trim() == "")
     {
         document.getElementById("workemailerror").style.display="block";
         document.getElementById("workemailerror").innerHTML="Please fill in the work email!";
         validateemail=0;
     }
     else
     {
         var x=document.getElementById("workemail").value;
        var atpos=x.indexOf("@");
        var dotpos=x.lastIndexOf(".");
        if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length)
          {
              document.getElementById("workemailerror").style.display="block";
               document.getElementById("workemailerror").innerHTML="Please enter a valid work email!";
               validateemail=0;
          }
          else
          {
             validateemail=1;
              document.getElementById("workemailerror").style.display="none";
              checkEmail(x);
          }
     }
     if(document.getElementById("pwd").value.trim() == "")
     {
         document.getElementById("pwderror").style.display="block";
         document.getElementById("pwderror").innerHTML="Please fill in the password!";
         validatepwd=0;
     }
     else
     {
         document.getElementById("pwderror").style.display="none";
         validatepwd=1;
     }

     if(document.getElementById("firstname").value.trim() == "")
     {
         document.getElementById("fnameerror").style.display="block";
         document.getElementById("fnameerror").innerHTML="Please fill in the First Name!";
         validatefname=0;
     }
     else
     {
         document.getElementById("fnameerror").style.display="none";
         validatefname=1;
     }
     if(document.getElementById("lastname").value.trim() == "")
     {
         document.getElementById("lnameerror").style.display="block";
         document.getElementById("lnameerror").innerHTML="Please fill in the last name!";
         validatelname=0;
     }
     else
     {
         document.getElementById("lnameerror").style.display="none";
         validatelname=1;
     }
    
     if(document.getElementById("cpwd").value.trim() == "")
     {
         document.getElementById("cpwderror").style.display="block";
         document.getElementById("cpwderror").innerHTML="Please confirm your password !";
         validatecpwd=0;
     }
     else
     {
 
         if (document.getElementById('cpwd').value != document.getElementById('pwd').value) {
             document.getElementById("cpwderror").style.display="block";
             document.getElementById("cpwderror").innerHTML="Confirm password should match the password!";
             validatecpwd=0;
         } else {
             document.getElementById("cpwderror").style.display="none";
             validatecpwd=1;
         }
     }
     if(document.getElementById("user_userTimezone").value.trim() == "")
     {
         document.getElementById("timezoneerror").style.display="block";
         document.getElementById("timezoneerror").innerHTML="Please select your timezone!";
         validatetimezone=0;
     }
     else
     {
         document.getElementById("timezoneerror").style.display="none";
         validatetimezone=1;
    
     }
     if(validateemail==0 || validatepwd==0 || validatecpwd==0 || validateutype==0 || validatelname==0 || validatefname==0 || validatetimezone==0 || emailExists==0)
     {
         return false ;
     }
     else
     {
         return true;
     }
 }
 
function checkEmail(emailId)
 {
 			var hostname=window.location.hostname;
		      //alert("http://myappone.com:3000/campaigns/updatestatus?campaignid="+campaignid+"&status="+status);
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
				document.getElementById("workemailerror").style.display="none";
				emailExists=01;
			}
			else if(xmlhttp.responseText=="1")
			{
			  document.getElementById("workemailerror").style.display="block";
               		  document.getElementById("workemailerror").innerHTML="Email ID already exists!";
               		  emailExists=0;
			}
			return xmlhttp.responseText ;
			}
			}
	
			xmlhttp.open("GET","http://"+hostname+":3000/users/checkEmail?email="+emailId,true);
			xmlhttp.send();
 }

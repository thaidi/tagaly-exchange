var campaignExists=true;
function checkCampaignName(campaignName) {
	var hostname = "/campaigns/checkCampaignName";
	$.ajax({
		type: "GET",
		url: hostname,
		data: "campaignName=" + campaignName ,
		success: function(data){
			if(data=="yes" && document.getElementById("campaignoldName").value != campaignName)
			{
				document.getElementById("campaignNameerrorText").innerHTML="Campaign Name already exists!";
				document.getElementById("campaignNameerrorText").style.display="block";
				campaignExists=false;
			}
			else
			{
				campaignExists=true;
				document.getElementById("campaignNameerrorText").style.display="none";
				
			}
		}
	});
	return ;
}
function checkCampaignNameAdunits(campaignName) {
	var hostname = "/campaigns/checkCampaignName";
  document.getElementById("campaignExists").value ="checking";
	document.getElementById("submitCamp").disabled = true;
	$.ajax({
		type: "GET",
		url: hostname,
		data: "campaignName=" + campaignName ,
		success: function(data){
			if(data=="yes" && document.getElementById("campaignoldName").value != campaignName) {
				document.getElementById("campaignNameerrorText").innerHTML="Campaign Name already exists!";
				document.getElementById("campaignNameerrorText").style.display="block";
  			document.getElementById("campaignExists").value = "yes";
				document.getElementById("submitCamp").disabled = false;
			} else {
  			document.getElementById("campaignExists").value = "no";
				document.getElementById("campaignNameerrorText").style.display="none";
				document.getElementById("submitCamp").disabled = false;
			}
		},
    error: function(XMLHttpRequest, textStatus, errorThrown) { 
				document.getElementById("campaignExists").value = "yes";
				document.getElementById("submitCamp").disabled = false;
    }  
	});
}

function checkdates()
{
  	if(document.getElementById("campaign_start_date").value.trim() == "")
    	{
    		document.getElementById("startDateerrortext").innerHTML="Please select the start date!";
    		document.getElementById("startDateerrortext").style.display="block";
    		validatestartend=false;
    		
    	}
    	else
    	{
    			var startDateValue=document.getElementById("campaign_start_date").value ;
    			var d1 = startDateValue.split('/');
    				var month = startDateValue.substring(0, 2);
            var date = startDateValue.substring(3, 5);
            var year = startDateValue.substring(6, 10);

            var enteredDate = new Date(year, month - 1, date);
 
						todayDate=new Date();
						if(enteredDate < todayDate)
						{
							document.getElementById("startDateerrortext").innerHTML="Start date cannot be less than today's date!";
    					document.getElementById("startDateerrortext").style.display="block";
    					validatestartend=false;
						}
						else
						{
							document.getElementById("startDateerrortext").style.display="none";
							validatestartend=true;
						}

    	}
    	if(document.getElementById("campaign_end_date").value.trim() == "")
    	{
    		document.getElementById("startDateerrortext").style.display="none";
    		document.getElementById("endDateerrortext").innerHTML="Please select the end date!";
    		document.getElementById("endDateerrortext").style.display="block";
    		validatestartend=false;
    	}
    	else
    	{
    			var endDateValue=document.getElementById("campaign_end_date").value ;
    			var d1 = endDateValue.split('/');
    				var month = endDateValue.substring(0, 2);
            var date = endDateValue.substring(3, 5);
            var year = endDateValue.substring(6, 10);
            
            var startDateValue=document.getElementById("campaign_start_date").value ;
    				var d1 = startDateValue.split('/');
    				var smonth = startDateValue.substring(0, 2);
            var sdate = startDateValue.substring(3, 5);
            var syear = startDateValue.substring(6, 10);

            var enteredDate = new Date(year, month - 1, date);
            var senteredDate = new Date(syear, smonth - 1, sdate);
 
						todayDate=new Date();
						if(enteredDate < senteredDate)
						{
							document.getElementById("endDateerrortext").innerHTML="End date cannot be less than start date!";
    					document.getElementById("endDateerrortext").style.display="block";
    					validatestartend=false;
						}
						else
						{
							document.getElementById("endDateerrortext").style.display="none";
							validatestartend=true;
						}

    	}
}

/////




$(function() {
var availableTags = [
"Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegowina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo", "Congo, the Democratic Republic of the", "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia (Hrvatska)", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands", "Fiji", "Finland", "France", "France Metropolitan", "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard and Mc Donald Islands", "Holy See (Vatican City State)", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kuwait", "Kyrgyzstan", "Lao, People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia, The Former Yugoslav Republic of", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of", "Monaco", "Mongolia", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore", "Slovakia (Slovak Republic)", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia and the South Sandwich Islands", "Spain", "Sri Lanka", "St. Helena", "St. Pierre and Miquelon", "Sudan", "Suriname", "Svalbard and Jan Mayen Islands", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic", "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Virgin Islands (British)", "Virgin Islands (U.S.)", "Wallis and Futuna Islands", "Western Sahara", "Yemen", "Yugoslavia", "Zambia", "Zimbabwe"
];
function split( val ) {
return val.split( /,\s*/ );
}
function extractLast( term ) {
return split( term ).pop();
}
$( "#countries" )
// don't navigate away from the field on tab when selecting an item
.bind( "keydown", function( event ) {
if ( event.keyCode === $.ui.keyCode.TAB &&
$( this ).data( "ui-autocomplete" ).menu.active ) {
event.preventDefault();
}
})
.autocomplete({
minLength: 0,
source: function( request, response ) {
// delegate back to autocomplete, but extract the last term
response( $.ui.autocomplete.filter(
availableTags, extractLast( request.term ) ) );
},
focus: function() {
// prevent value inserted on focus
return false;
},
select: function( event, ui ) {
var terms = split( this.value );
// remove the current input
terms.pop();
// add the selected item
terms.push( ui.item.value );
// add placeholder to get the comma-and-space at the end
terms.push( "" );
this.value = terms.join( ", " );
return false;
}
});
});









$(function() {
var availableTags = [
"Abilene-Sweetwater, TX", "Albany, GA","Albany-Schenectady-Troy, NY","Albuquerque-Santa Fe, NM","Alexandria, LA","Alpena, MI","Amarillo, TX","Anchorage, AK","Atlanta, GA","Augusta, GA","Austin, TX","Bakersfield, CA","Baltimore, MD","Bangor, ME","Baton Rouge, LA","Beaumont-Port Arthur, TX","Bend, OR","Billings, MT","Biloxi-Gulfport, MS","Binghamton, NY","Birmingham, AL","Bluefield-Beckley-Oak Hill, WV","Boise, ID","Boston, MA-Manchester, NH","Bowling Green, KY","Buffalo, NY","Burlington, VT-Plattsburgh, NY","Butte-Bozeman, MT","Casper-Riverton, WY","Cedar Rapids-Waterloo-Iowa City, IA","Champaign &amp; Springfield-Decatur,IL","Charleston, SC","Charleston-Huntington, WV","Charlotte, NC","Charlottesville, VA","Chattanooga, TN","Cheyenne, WY-Scottsbluff, NE","Chicago, IL","Chico-Redding, CA","Cincinnati, OH","Clarksburg-Weston, WV","Cleveland-Akron (Canton), OH","Colorado Springs-Pueblo, CO","Columbia, SC","Columbia-Jefferson City, MO","Columbus, GA","Columbus, OH","Columbus-Tupelo-West Point, MS","Corpus Christi, TX","Dallas-Ft. Worth, TX","Davenport,IA-Rock Island-Moline,IL","Dayton, OH","Denver, CO","Des Moines-Ames, IA","Detroit, MI","Dothan, AL","Duluth, MN-Superior, WI","El Paso, TX","Elmira, NY","Erie, PA","Eugene, OR","Eureka, CA","Evansville, IN","Fairbanks, AK","Fargo-Valley City, ND","Flint-Saginaw-Bay City, MI","Florence-Myrtle Beach, SC","Fresno-Visalia, CA","Ft. Myers-Naples, FL","Ft Smith-Springdale, AR","Ft. Wayne, IN","Gainesville, FL","Glendive, MT","Grand Junction-Montrose, CO","Grand Rapids-Kalamazoo, MI","Great Falls, MT","Green Bay-Appleton, WI","Greensboro-Winston Salem, NC","Greenville-New Bern-Washington, NC","Greenville-Spartanburg, SC","Greenwood-Greenville, MS","Harlingen-Weslaco-McAllen, TX","Harrisburg-Lancaster-York, PA","Harrisonburg, VA","Hartford &amp; New Haven, CT","Hattiesburg-Laurel, MS","Helena, MT","Honolulu, HI","Houston, TX","Huntsville-Decatur (Florence), AL","Idaho Falls-Pocatello, ID","Indianapolis, IN","Jackson, MS","Jackson, TN","Jacksonville, FL","Johnstown-Altoona, PA","Jonesboro, AR","Joplin, MO-Pittsburg, KS","Juneau, AK","Kansas City, MO","Knoxville, TN","La Crosse-Eau Claire, WI","Lafayette, IN","Lafayette, LA",
"Lake Charles, LA","Lansing, MI","Laredo, TX","Las Vegas, NV","Lexington, KY","Lima, OH","Lincoln &amp; Hastings-Kearney, NE","Little Rock-Pine Bluff, AR","Los Angeles, CA","Louisville, KY","Lubbock, TX","Macon, GA","Madison, WI","Mankato, MN","Marquette, MI","Medford-Klamath Falls, OR","Memphis, TN","Meridian, MS","Miami-Ft. Lauderdale, FL","Milwaukee, WI","Minneapolis-St. Paul, MN","Minot-Bismarck-Dickinson, ND","Missoula, MT","Mobile, AL-Pensacola, FL","Monroe, LA-El Dorado, AR","Monterey-Salinas, CA","Montgomery (Selma), AL","Nashville, TN","New Orleans, LA","New York, NY","Norfolk-Portsmouth-Newport News,VA","North Platte, NE","Odessa-Midland, TX","Oklahoma City, OK","Omaha, NE","Orlando-Daytona Beach, FL","Ottumwa, IA-Kirksville, MO","Paducah, KY-Harrisburg, IL","Palm Springs, CA","Panama City, FL","Parkersburg, WV","Peoria-Bloomington, IL","Philadelphia, PA","Phoenix, AZ","Pittsburgh, PA","Portland, OR","Portland-Auburn, ME","Presque Isle, ME","Providence, RI-New Bedford, MA","Quincy, IL-Hannibal, MO-Keokuk, IA","Raleigh-Durham (Fayetteville), NC","Rapid City, SD","Reno, NV","Richmond-Petersburg, VA","Roanoke-Lynchburg, VA","Rochester-Austin, MN-Mason City, IA","Rochester, NY","Rockford, IL","Sacramento-Stockton-Modesto, CA","Salisbury, MD","Salt Lake City, UT","San Angelo, TX","San Antonio, TX","San Diego, CA","San Francisco-Oakland-San Jose, CA","Santa Barbara-San Luis Obispo, CA","Savannah, GA","Seattle-Tacoma, WA","Sherman, TX-Ada, OK","Shreveport, LA","Sioux City, IA","Sioux Falls(Mitchell), SD","South Bend-Elkhart, IN","Spokane, WA","Springfield, MO","Springfield-Holyoke, MA","St. Joseph, MO","St. Louis, MO","Syracuse, NY","Tallahassee, FL-Thomasville, GA","Tampa-St Petersburg (Sarasota), FL","Terre Haute, IN","Toledo, OH","Topeka, KS","Traverse City-Cadillac, MI","Tri-Cities, TN-VA","Tucson (Sierra Vista), AZ","Tulsa, OK","Twin Falls, ID","Tyler-Longview(Nacogdoches), TX","Utica,NY","Victoria, TX","Waco-Temple-Bryan, TX","Washington, DC (Hagerstown, MD)","Watertown, NY","Wausau-Rhinelander, WI","West Palm Beach-Ft. Pierce, FL","Wheeling, WV-Steubenville, OH","Wichita Falls, TX &amp; Lawton, OK","Wichita-Hutchinson, KS","Wilkes Barre-Scranton, PA","Wilmington, NC","Yakima-Pasco-Richland-Kennewick, WA","Youngstown, OH","Yuma, AZ-El Centro, CA","Zanesville, OH"
];
function split( val ) {
return val.split( /,\s*/ );
}
function extractLast( term ) {
return split( term ).pop();
}
$( "#dmas" )
// don't navigate away from the field on tab when selecting an item
.bind( "keydown", function( event ) {
if ( event.keyCode === $.ui.keyCode.TAB &&
$( this ).data( "ui-autocomplete" ).menu.active ) {
event.preventDefault();
}
})
.autocomplete({
minLength: 0,
source: function( request, response ) {
// delegate back to autocomplete, but extract the last term
response( $.ui.autocomplete.filter(
availableTags, extractLast( request.term ) ) );
},
focus: function() {
// prevent value inserted on focus
return false;
},
select: function( event, ui ) {
var terms = split( this.value );
// remove the current input
terms.pop();
// add the selected item
terms.push( ui.item.value );
// add placeholder to get the comma-and-space at the end
terms.push( "" );
this.value = terms.join( ", " );
return false;
}
});
});

var week = [
    {value:'monday',text: 'Monday'},
    {value:'tuesday',text: 'Tuesday'},
    {value:'wednesday',text:'Wednesday'},
    {value:'thursday', text:'Thursday'},
    {value:'friday', text:'Friday'},
    {value:'saturday', text:'Saturday'},
    {value:'sunday', text:'Sunday'}
];
var hrs = [
    {value: "0", text: "0"},
    {value: "1", text: "1"},
    {value: "2", text: "2"},
    {value: "3", text: "3"},
    {value: "4", text: "4"},
    {value: "5", text: "5"},
    {value: "6", text: "6"},
    {value: "7", text: "7"},
    {value: "8", text: "8"},
    {value: "9", text: "9"},
    {value: "10", text: "10"},
    {value: "11", text: "11"},
    {value: "12", text: "12"},
    {value: "13", text: "13"},
    {value: "14", text: "14"},
    {value: "15", text: "15"},
    {value: "16", text: "16"},
    {value: "17", text: "17"},
    {value: "18", text: "18"},
    {value: "19", text: "19"},
    {value: "20", text: "20"},
    {value: "21", text: "21"},
    {value: "22", text: "22"},
    {value: "23", text: "23"}
    
];
var mins = [
    {value: "0", text: "0"},
    {value: "15", text: "15"},
    {value: "30", text: "30"},
    {value: "45", text: "45"}
];

function addRow(rowId)
{
		var rowid=document.getElementById("trId").value;

		  var table = document.getElementById("dayparting");
		  var rowCount = table.rows.length;
		  var row = table.insertRow(rowCount);
		  row.setAttribute("id","daypartingRow"+rowid);
		  var cell1 = row.insertCell(0);
			    
		  var select = document.createElement('select');
		  select.setAttribute("name","campaign[dayparting_day"+rowid+"]");
		  select.setAttribute("id","campaign_dayparting_day"+rowid);
		    i = 0,
		    il = week.length;

		for (; i < il; i += 1) {
		    option = document.createElement('option');
		    option.setAttribute('value', week[i].value);
		    option.appendChild(document.createTextNode(week[i].text));
		    select.appendChild(option);
		}
		  cell1.appendChild(select);
		  
		  var cell2= row.insertCell(1);
		  var select2 = document.createElement('select');
		  select2.setAttribute("name","campaign[dayparting_start_hr"+rowid+"]");
		  select2.setAttribute("id","campaign_dayparting_start_hr"+rowid);
		  select2.setAttribute("onchange","validateHr(this.id)");;
		    i = 0,
		    il = hrs.length;

		for (; i < il; i += 1) {
		    option = document.createElement('option');
		    option.setAttribute('value', hrs[i].value);
		    option.appendChild(document.createTextNode(hrs[i].text));
		    select2.appendChild(option);
		}
		  cell2.appendChild(select2);
		  
		  
		  var cell3= row.insertCell(2);
		  var select3 = document.createElement('select');
		  select3.setAttribute("name","campaign[dayparting_start_min"+rowid+"]");
		  select3.setAttribute("id","campaign_dayparting_start_min"+rowid);
		  select3.setAttribute("onchange","validateMin(this.id)");
		    i = 0,
		    il = mins.length;

		for (; i < il; i += 1) {
		    option = document.createElement('option');
		    option.setAttribute('value', mins[i].value);
		    option.appendChild(document.createTextNode(mins[i].text));
		    select3.appendChild(option);
		}
		
		  cell3.appendChild(select3);
		  
		  
		  var cell4 = row.insertCell(3);
		  cell4.innerHTML = "&nbsp;to&nbsp;";
		  
		  var cell5 = row.insertCell(4);
		  var select5 = document.createElement('select');
		  select5.setAttribute("name","campaign[dayparting_end_hr"+rowid+"]");
		  select5.setAttribute("id","campaign_dayparting_end_hr"+rowid);
		  select5.setAttribute("onchange","validateHr(this.id)");
		    i = 0,
		    il = hrs.length;

		for (; i < il; i += 1) {
		    option = document.createElement('option');
		    option.setAttribute('value', hrs[i].value);
		    option.appendChild(document.createTextNode(hrs[i].text));
		    select5.appendChild(option);
		}
		  var errordiv=document.createElement('div');
		errordiv.setAttribute("id","cenderror"+rowid);
		errordiv.setAttribute("class","error");
		errordiv.style.width="210px";
		errordiv.style.marginLeft="1px";
		  cell5.appendChild(select5);
		  cell5.appendChild(errordiv);
		  
		  
		  var cell6= row.insertCell(5);
		  var select6 = document.createElement('select');
		  select6.setAttribute("name","campaign[dayparting_end_min"+rowid+"]");
		  select6.setAttribute("id","campaign_dayparting_end_min"+rowid);
		  select6.setAttribute("onchange","validateMin(this.id)");
		    i = 0,
		    il = mins.length;

		for (; i < il; i += 1) {
		    option = document.createElement('option');
		    option.setAttribute('value', mins[i].value);
		    option.appendChild(document.createTextNode(mins[i].text));
		    select6.appendChild(option);
		}
		  cell6.appendChild(select6);
		  var cell7 = row.insertCell(6);
		  cell7.innerHTML = " <a href='' onclick='deleteRow("+rowid+")'>X</a> ";
		  rowid ++;
		  document.getElementById("trId").value=rowid
		  var count=document.getElementById('dayparting').getElementsByTagName('tr').length;
		  document.getElementById("countDayparting").value=count;

}

function validateDate(id) {
setTimeout(function () {
	val = document.getElementById(id).value;
	startDateValue = document.getElementById("campaign_start_date").value;
	endDateValue = document.getElementById("campaign_end_date").value;
	if(id == "campaign_start_date") { divId = "startDateerrortext"; }
	if(id == "campaign_end_date") { divId = "endDateerrortext"; }
	if(val == "") {
		document.getElementById(divId).innerHTML="Please select the start date!";
		document.getElementById(divId).style.display="block";
	} else {
		if(id == "campaign_start_date") {
			if(startDateValue.trim() != "" && endDateValue.trim() != "" ) {
				var d1 = startDateValue.split('/');
				d1 = new Date(d1[1], d1[0] - 1, d1[2]);
				var d2 = endDateValue.split('/');
				d2 = new Date(d2[1], d2[0] - 1, d2[2]);
				if (d2 > d1) {
					document.getElementById("endDateerrortext").innerHTML="";
					document.getElementById("endDateerrortext").style.display="none";
					document.getElementById(divId).innerHTML="";
					document.getElementById(divId).style.display="none";
				} else if (d2 == d1) {
					document.getElementById(divId).innerHTML="Start date cannot be equal to end date";
					document.getElementById(divId).style.display="block";
				} else {
					document.getElementById(divId).innerHTML="Start date cannot be greater than end date";
					document.getElementById(divId).style.display="block";
				}
			}
		} else if(id == "campaign_end_date") {
			if(startDateValue.trim() != "" && endDateValue.trim() != "" ) {
				var d1 = startDateValue.split('/');
				d1 = new Date(d1[1], d1[0] - 1, d1[2]);
				var d2 = endDateValue.split('/');
				d2 = new Date(d2[1], d2[0] - 1, d2[2]);
				if (d2 > d1) {
					document.getElementById("startDateerrortext").innerHTML="";
					document.getElementById("startDateerrortext").style.display="none";
					document.getElementById(divId).innerHTML="";
					document.getElementById(divId).style.display="none";
				} else if (d2 == d1){
					document.getElementById(divId).innerHTML="Start date cannot be equal to end date";
					document.getElementById(divId).style.display="block";
				} else {
					document.getElementById(divId).innerHTML="Start date cannot be greater than end date";
					document.getElementById(divId).style.display="block";
				}
			} else {
					document.getElementById(divId).innerHTML="Select the start date!";
					document.getElementById(divId).style.display="block";
			}
		}
	}
}, 200);
}
function validateMin(id) {
	var con = "no";
	if(id.indexOf("campaign_dayparting_end_min") >= 0) {
		con = "yes"
		idVal = id.substr(27);
		endMinId = id;
		startHrId = "campaign_dayparting_start_hr" + idVal;
		startMinId = "campaign_dayparting_start_min" + idVal;
		endHrId = "campaign_dayparting_end_hr" + idVal;
		cenderror = "cenderror" + idVal;
		startHrIdVal = document.getElementById(startHrId).value;
		startMinIdVal = document.getElementById(startMinId).value;
		endHrIdVal = document.getElementById(endHrId).value;
		endMinIdVal = document.getElementById(endMinId).value;
	} else if(id.indexOf("campaign_dayparting_start_min") >= 0) {
		con = "yes"
		idVal = id.substr(29);
		startMinId = id;
		startHrId = "campaign_dayparting_start_hr" + idVal;
		endHrId = "campaign_dayparting_end_hr" + idVal;
		endMinId = "campaign_dayparting_end_min" + idVal;
		cenderror = "cenderror" + idVal;
		startHrIdVal = document.getElementById(startHrId).value;
		startMinIdVal = document.getElementById(startMinId).value;
		endHrIdVal = document.getElementById(endHrId).value;
		endMinIdVal = document.getElementById(endMinId).value;
	}
	if(con == "yes") {
		if(parseInt(endHrIdVal) < parseInt(startHrIdVal)) {
			document.getElementById(cenderror).innerHTML = "Endding Time cannot be lessthan Starting Time ";
			document.getElementById(cenderror).style.display = "block";
		} else if(parseInt(endHrIdVal) == parseInt(startHrIdVal)) {
			if(endMinIdVal < startMinIdVal){
				document.getElementById(cenderror).innerHTML = "Endding Time cannot be lessthan Starting Time ";
				document.getElementById(cenderror).style.display = "block";
			} else if(endMinIdVal == startMinIdVal){
				document.getElementById(cenderror).innerHTML = "Endding Time cannot be equals Starting Time ";
				document.getElementById(cenderror).style.display = "block";
			} else {
				document.getElementById(cenderror).innerHTML = "";
				document.getElementById(cenderror).style.display = "none";
			}
		} else {
			document.getElementById(endMinId).value = 0;
			document.getElementById(cenderror).innerHTML = "";
			document.getElementById(cenderror).style.display = "none";
		}
	}
}
function validateHr(id) {
	var con = "no";
	if(id.indexOf("campaign_dayparting_end_hr") >= 0) {
		con = "yes"
		idVal = id.substr(26);
		endHrId = id;
		startHrId = "campaign_dayparting_start_hr" + idVal;
		startMinId = "campaign_dayparting_start_min" + idVal;
		endMinId = "campaign_dayparting_end_min" + idVal;
		cenderror = "cenderror" + idVal;
		startHrIdVal = document.getElementById(startHrId).value;
		startMinIdVal = document.getElementById(startMinId).value;
		endHrIdVal = document.getElementById(endHrId).value;
		endMinIdVal = document.getElementById(endMinId).value;
	} else if(id.indexOf("campaign_dayparting_start_hr") >= 0) {
		con = "yes"
		idVal = id.substr(28);
		startHrId = id;
		startMinId = "campaign_dayparting_start_min" + idVal;
		endHrId = "campaign_dayparting_end_hr" + idVal;
		endMinId = "campaign_dayparting_end_min" + idVal;
		cenderror = "cenderror" + idVal;
		startHrIdVal = document.getElementById(startHrId).value;
		startMinIdVal = document.getElementById(startMinId).value;
		endHrIdVal = document.getElementById(endHrId).value;
		endMinIdVal = document.getElementById(endMinId).value;
	}
		if(con == "yes") {
			if(parseInt(endHrIdVal) < parseInt(startHrIdVal)) {
				document.getElementById(cenderror).innerHTML = "Endding Time cannot be lessthan Starting Time ";
				document.getElementById(cenderror).style.display = "block";
			} else if(parseInt(endHrIdVal) == parseInt(startHrIdVal)) {
				if(startMinIdVal == 0){ endMinIdValSet = 15 }
				else if(startMinIdVal == 15){ endMinIdValSet = 30 }
				else if(startMinIdVal == 30){ endMinIdValSet = 45 }
				if ( startMinIdVal < 45 ) {
					document.getElementById(endMinId).value = endMinIdValSet
					document.getElementById(cenderror).innerHTML = "";
					document.getElementById(cenderror).style.display = "none";
				} else {
					document.getElementById(cenderror).innerHTML = "Endding Time cannot be lessthan Starting Time ";
					document.getElementById(cenderror).style.display = "block";
				}
			} else {
				document.getElementById(endMinId).value = 0;
				document.getElementById(cenderror).innerHTML = "";
				document.getElementById(cenderror).style.display = "none";
			}
		}
}
function deleteRow(rowId)
{
	var row = document.getElementById("daypartingRow"+rowId);
        row.parentNode.removeChild(row);
}


function setbidType(bidtype)
{
  document.getElementById("bidtype").value=bidtype;
}

// Calculate campaign cost
function calculateCost()
{
    var idbidtype1=""
    var idbidtype2=""
    var bidType=document.getElementById("bidtype");
    if(bidType.value=="cpm")
    {
      idbidtype1="impressions";
      idbidtype2="campaign_cpm";
    }
    else if(bidType.value=="cpc")
    {
      idbidtype1="clicks";
      idbidtype2="campaign_cpc";
    }
    else if(bidType.value=="cpa")
    {
      idbidtype1="conversions";
      idbidtype2="campaign_cpa";
    }
    if(parseInt(document.getElementById(idbidtype1).value) < 1 ||  parseInt(document.getElementById(idbidtype1).value) > 9223372036854775807)
			{
					document.getElementById(idbidtype1+"error").style.display = 'block';
          document.getElementById(idbidtype1+"error").innerHTML = 'Value should be in the range 1 to 9223372036854775807';
          document.getElementById("form-"+bidType.value).style.marginTop="-73px" 
          bidValidation1=false ;
			}
			else
			{
					document.getElementById(idbidtype1+"error").style.display = 'none';
					document.getElementById("form-"+bidType.value).style.marginTop="-53px" 
					bidtype1ToMul=document.getElementById(idbidtype1).value / 1000 ;
					var campaignCost=bidtype1ToMul * document.getElementById(idbidtype2).value ;
					if(!isNaN(campaignCost))
					{
						document.getElementById(bidType.value+"campaigncost").value="$ " + campaignCost.toFixed(2);
					}
					else
					{
						document.getElementById(bidType.value+"campaigncost").value="$ 0 ";
					}
    }
}
// Validation starts here
function validateCampaign()
{
    //Ads validation
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
    }
    else
    {
       document.getElementById("aderrorText").innerHTML="Please select atleast one Ad";
       document.getElementById("aderrorText").style.display="block";
    }
    
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
				 window.location.hash='specific-retargets';
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
    	 document.getElementById("geoCountrieserrorText").style.display="none";
    	  document.getElementById("geoDmaserrorText").style.display="none";
    }
    else if(document.getElementById("campaign_geotargeting_countries").checked==true)
    {
    	if(document.getElementById("countries").value.trim() == "")
    	{
    		 document.getElementById("geoCountrieserrorText").innerHTML="Please select atleast one Country!";
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
    		 document.getElementById("geoDmaserrorText").innerHTML="Please select atleast one Dma!";
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
    		document.getElementById("budgeterrorText").innerHTML="Campaign Budget should be more than zero!";
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
    validatestartdate=true;
    if(document.getElementById("run-campaign-continuously").checked==false)
    {
    	if(document.getElementById("campaign_start_date").value.trim() == "")
    	{
    		document.getElementById("startDateerrortext").innerHTML="Please select the start date!";
    		document.getElementById("startDateerrortext").style.display="block";
    		validatestartdate=false;
    		
    	}
    	else
    	{
    			var startDateValue=document.getElementById("campaign_start_date").value ;
    			var d1 = startDateValue.split('/');
    				var month = startDateValue.substring(0, 2);
            var date = startDateValue.substring(3, 5);
            var year = startDateValue.substring(6, 10);

            var enteredDate = new Date(year, month - 1, date);
 
						todayDate=new Date();
						todayDate.setHours(0,0,0,0)
						if(enteredDate < todayDate)
						{
							document.getElementById("startDateerrortext").innerHTML="Start date cannot be less than today's date!";
    					document.getElementById("startDateerrortext").style.display="block";
    					validatestartdate=false;
						}
						else
						{
							document.getElementById("startDateerrortext").style.display="none";
							validatestartdate=true;
						}

    	}
    	if(document.getElementById("campaign_end_date").value.trim() == "")
    	{
    		document.getElementById("startDateerrortext").style.display="none";
    		document.getElementById("endDateerrortext").innerHTML="Please select the end date!";
    		document.getElementById("endDateerrortext").style.display="block";
    		validatestartend=false;
    	}
    	else
    	{
    			var endDateValue=document.getElementById("campaign_end_date").value ;
    			var d1 = endDateValue.split('/');
    				var month = endDateValue.substring(0, 2);
            var date = endDateValue.substring(3, 5);
            var year = endDateValue.substring(6, 10);
            
            var startDateValue=document.getElementById("campaign_start_date").value ;
    				var d1 = startDateValue.split('/');
    				var smonth = startDateValue.substring(0, 2);
            var sdate = startDateValue.substring(3, 5);
            var syear = startDateValue.substring(6, 10);

            var enteredDate = new Date(year, month - 1, date);
            var senteredDate = new Date(syear, smonth - 1, sdate);
 
						todayDate=new Date();
						if(enteredDate < senteredDate)
						{
							document.getElementById("endDateerrortext").innerHTML="End date cannot be less than start date!";
    					document.getElementById("endDateerrortext").style.display="block";
    					validatestartend=false;
						}
						else
						{
							document.getElementById("endDateerrortext").style.display="none";
							validatestartend=true;
						}

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
    if(document.getElementById("run-ad-continuously").checked!=true)
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
	    		//document.getElementById("campaign_dayparting_end_hr"+i).style.marginTop="37px";
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
    
    if(document.getElementById("campaign_type").value=="ad_placement")
    {
    		validateAdUnit=false ;
    	 	var adunitCheckboxs=document.getElementsByClassName("campaignadunits");
				var validateAdUnit=false;
				for(var i=0,l=adunitCheckboxs.length;i<l;i++)
				{
				    if(adunitCheckboxs[i].checked)
				    {
				        validateAdUnit=true;
				    }
				}
				if(validateAdUnit)
				{
				   document.getElementById("aduniterrorText").style.display="none";
				}
				else
				{
				   document.getElementById("aduniterrorText").innerHTML="Please select atleast one AdUnit";
				   document.getElementById("aduniterrorText").style.display="block";
				}
    }
    else
    {
    	validateAdUnit=true ;
    }
 
    if(checkedAtLeastOneAd==false || checkedAtLeastOneRetarget==false || checkedAtLeastOneconversionGoal==false || validateGeotargeting==false || validateCampaignName==false || validateCampaignBudget==false || bidValidation1==false || bidValidation2==false || validatestartend==false || validateAdUnit == false || campaignExists==false || validatestartdate==false)
    {
    /* alert(checkedAtLeastOneAd + "====" + checkedAtLeastOneRetarget + "====" + checkedAtLeastOneconversionGoal + "====" + validateGeotargeting + "====" + validateCampaignName + "====" + validateCampaignBudget + "====" + bidValidation1 + "====" + bidValidation2 + "====" + validatestartend + "====" + validateAdUnit + "====" + campaignExists + "====" + validatestartdate) */
    	return false
    }
    else
    {
    	return true;
    }
	
}



//// Functio to calculate minimum bid
function calculateMinBid()
{
	var bidType=document.getElementById("bidtype").value;
	var geoTargetingType="" ;
	var geoTargetingArray = new Array();
	var geoTargeting="";
	var dayparting=""
	var dayp="";
	var hr1p="";
	var min1p="";
	var hr2p="";
	var min2p="";
	if(document.getElementById("campaign_geotargeting_all").checked==true)
	{
		geoTargetingType=document.getElementById("campaign_geotargeting_all").value;
		geoTargeting="all";
	}
	else if(document.getElementById("campaign_geotargeting_countries").checked==true)
	{
		geoTargetingType=document.getElementById("campaign_geotargeting_countries").value;
		geoTargeting=document.getElementById("countries");
		for (var i = 0; i < geoTargeting.options.length; i++) 
		{
     if(geoTargeting.options[i].selected ==true){
          geoTargetingArray.push(geoTargeting.options[i].value);
      }
  	}
  	geoTargeting=geoTargetingArray.join(" , ");
	}	
	else
	{
		geoTargetingType=document.getElementById("campaign_geotargeting_dmas").value;
		geoTargeting=document.getElementById("dmas");
		for (var i = 0; i < geoTargeting.options.length; i++) 
		{
     if(geoTargeting.options[i].selected ==true){
          geoTargetingArray.push(geoTargeting.options[i].value);
      }
  	}
  	geoTargeting=geoTargetingArray.join(" , ");
	}
	var devicePreference=document.getElementById("device_preference").value;
	var count=0;
	if(document.getElementById("run-ad-continuously").checked==true)
	{
		dayparting="all"
	}
	else
	{
		count=document.getElementById("countDayparting").value;
		
		var i=1;
		while(i <= count)
		{
      dayp="campaign_dayparting_day" + i;
      hr1p="campaign_dayparting_start_hr" + i ;
      min1p="campaign_dayparting_start_min" + i ;
      hr2p="campaign_dayparting_end_hr" + i ;
      min2p="campaign_dayparting_end_min" + i ;
      dayparting = dayparting + document.getElementById(dayp).value + "|" + document.getElementById(hr1p).value + ":" + document.getElementById(min1p).value + "|" + document.getElementById(hr2p).value + ":" + document.getElementById(min2p).value  + ","
      i=i+1
    }
    dayparting=dayparting.substring(0, dayparting.length - 1);
	}
	var hostname = "http://"+window.location.hostname+":3000/campaigns/minBid";
	
	
				
					$.ajax({
						type: "POST",
						url: hostname,
						data: "bidType=" + bidType +"&geoTargetingType="+geoTargetingType+"&geoTargeting="+geoTargeting+"&devicePreference="+devicePreference+"&dayparting="+dayparting,
						success: function(data){
						
							if(bidType=="cpm")
							{
								document.getElementById("campaign_cpm").value=data ;
							}
							else if(bidType=="cpa")
							{
								document.getElementById("campaign_cpa").value=data ;
							}
							else if(bidType=="cpc")
							{
								document.getElementById("campaign_cpc").value=data ;
							}
							
						}
					});
}

		function iframeLoaded(id,adType){
			$('.paulund_block_page').fadeOut().remove();
			var hostname = "http://"+window.location.hostname+":3000/preview/styleoptions?styleid="+id+"&adType="+adType;
			$.ajax({
				type: "GET",
				url: hostname,
				success: function(data){
					if(adType != "nativeAd"){
						$("#adunittypesel").html( data );
					} else {
						$("#ajaxData").html( data );
						$("#"+id).addClass("nativeAdStyleSelect");
						$("#radio_" + id).prop("checked", true);
						$("#selectedStyle").val(selectedStyle);
						$("#nextStep").prop("disabled",false);
					}
				}
			});
		}
		 function add_styles(){			
			$('.paulund_modal_box').css({ 
				'position':'absolute', 
				'left': '10%',
				'top': '10%',
				'display':'none',
				'height': '800px',
				'width': '1000px',
				'border':'1px solid #fff',
				'box-shadow': '0px 2px 7px #292929',
				'-moz-box-shadow': '0px 2px 7px #292929',
				'-webkit-box-shadow': '0px 2px 7px #292929',
				'border-radius':'10px',
				'-moz-border-radius':'10px',
				'-webkit-border-radius':'10px',
				'background': '#f2f2f2', 
				'z-index':'50',
			});
			$('.paulund_modal_close').css({
				'position':'relative',
				'top':'-25px',
				'left':'20px',
				'float':'right',
				'display':'block',
				'height':'50px',
				'width':'50px',
				'background': 'url(/assets/close.png) no-repeat',
			});
			$('.paulund_block_page').css({
				'position':'absolute',
				'top':'0',
				'left':'0',
				'background-color':'rgba(0,0,0,0.6)',
				'height':'1000px',
				'width':'100%',
				'z-index':'10'
			});
			$('.paulund_inner_modal_box').css({
				'background-color':'#fff',
				'height':'750px',
				'width': '950px',
				'padding':'10px',
				'margin':'15px',
				'border-radius':'10px',
				'-moz-border-radius':'10px',
				'-webkit-border-radius':'10px'
			});
		}
		
		 /**
		  * Create the block page div
		  */
		 function add_block_page(){
			var block_page = $('<div class="paulund_block_page"></div>');
			$(block_page).appendTo('body');
		}
		 	
		 /**
		  * Creates the modal box
		  */
		 function add_popup_box(adunitType){
			 var pop_up = $('<div class="paulund_modal_box"><a href="#" class="paulund_modal_close"></a><div class="paulund_inner_modal_box"><h2>Create Your style</h2><p><iframe style="width:950px; border-radius: 0 0 7px 7px; height:700px;" frameBorder="0" src="/styles/new/frame/'+adunitType+'"></iframe></p></div></div>');
			 $(pop_up).appendTo('.paulund_block_page');
			 $('.paulund_modal_close').click(function(){
				$(this).parent().fadeOut().remove();
				$('.paulund_block_page').fadeOut().remove();
			 });
		}
function setFormats(laptopsanddesktops,mobiles,tablets){	
		var adunitdevice = document.getElementById("adunitdevice").value;
		if(adunitdevice == 'Mobiles') {
			var sizes = mobiles;
			document.getElementById("adunitformat").disabled = false;
		} else if (adunitdevice == 'LaptopsAndDesktops') {
			var sizes = laptopsanddesktops;
			document.getElementById("adunitformat").disabled = false;
		} else if (adunitdevice == 'Tabs') {
			var sizes = tablets;
			document.getElementById("adunitformat").disabled = false;
		} else {
			document.getElementById("adunitformat").disabled = true;
		}
		var selectobject = document.getElementById("adunitformat");
		var sellength = selectobject.options.length;
		selectobject.options.length = 0;
		for(var item in sizes) {
			var adunitType = $("input[name='adunit[adtype]']:checked").val();
			if(adunitType == 'TextAd' || adunitType == 'TextAndDisplayAd') {
				if(item != '120x60' && item != '88x31' && item != '234x60' && item != '468x60') {
					$('<option value="'+item+'">'+sizes[item]+'</option>').appendTo('#adunitformat');
				}
			} else {
				$('<option value="'+item+'">'+sizes[item]+'</option>').appendTo('#adunitformat');
			}
		}
}
	$( document ).ready(function() {
		var id = document.getElementById("adunittypesel").value;
		var laptopsanddesktops = {
			"728x90":"728 x 90 Leaderboard",
			"120x60":"120 x 60 Button",
			"468x60":"468 x 60 Full Banner",
			"250x250":"250 x 250 Square",
			"240x400":"240 x 400  Fat Skyscraper",
			"234x60":"234 x 60  Half Banner",
			"88x31":"88 x 31  Button",
			"160x600":"160 x 600  Skyscraper"
		};
		var mobiles = {
			"120x20":"120 x 20",
			"168x28":"168 x 28",
			"216x36":"216 x 36",
			"300x250":"300 x 250[Smart Phones only]",
			"320x50":"320 x 50[Smart Phones only]",
			"300x50":"300 x 50[Smart Phones only]"
		};
		var tablets = {
			"300x250":"300 x 250",
			"468x60":"468 x 60",
			"728x90":"728 x 90",
			"1024x90":"1024 x 90",
		};
		setFormats(laptopsanddesktops,mobiles,tablets);
		src();
		$( "#adunitdevice" ).change(function() {
			setFormats(laptopsanddesktops,mobiles,tablets);
			src();
		});
		$( "input[name='adunit[adtype]']" ).click(function() {
			setFormats(laptopsanddesktops,mobiles,tablets);
		});
		$( ".inner-adtype" ).click(function() {
			setFormats(laptopsanddesktops,mobiles,tablets);
		});
	});
$( document ).ready(function() {
		$( "#submitcoloradunit" ).click(function() {
			var stylename = (document.getElementById("stylename").value).trim();
			if(stylename.length == 0){
				document.getElementById("stylenameerror").style.display = 'block';
				document.getElementById("stylenameerror").style.marginLeft = "3px";
				document.getElementById("stylenameerror").innerHTML = 'Name field cannot be blank';
				return false;
			}
				stylename = document.getElementById("stylename").value;
				var stylebackground = document.getElementById("stylebackground").value;
				var styleborder = document.getElementById("styleborder").value;
				var styletext = document.getElementById("styletext").value;
				var styletitle = document.getElementById("styletitle").value;
				var styleurl = document.getElementById("styleurl").value;
				var stylefontfamily = document.getElementById("stylefontfamily").value;
				if( document.getElementById("style_cornerstyle_0px").checked == true ) {
					stylecorner = "0px";
				}
				if( document.getElementById("style_cornerstyle_6px").checked == true ) {
					stylecorner = "6px";
				}
				if( document.getElementById("style_cornerstyle_10px").checked == true ) {
					stylecorner = "10px";
				}
				totalData = "stylename="+stylename + "&stylebackground="+stylebackground + "&styleborder="+styleborder + "&styletext="+styletext + "&styletitle="+styletitle + "&styleurl="+styleurl + "&stylefontfamily="+stylefontfamily + "&stylecorner="+stylecorner
				var hostname = "http://"+window.location.hostname+":3000/preview/addstyles";
				addStyleValue = addStyle(hostname, totalData);
					location.reload();
				
		});
	});
	
		function addStyle(hostname, totalData){
			$.ajax({
				type: "GET",
				url: hostname,
				data: totalData ,
				success: function(data){
					return true;
				},
			});
		}
	$( document ).ready(function() {
		$( "#style_cornerstyle_0px" ).click(function() {
			document.getElementById("bordervalue").value = document.getElementById("style_cornerstyle_0px").value;
		});
		$( "#style_cornerstyle_6px" ).click(function() {
			document.getElementById("bordervalue").value = document.getElementById("style_cornerstyle_6px").value;
		});
		$( "#style_cornerstyle_10px" ).click(function() {
			document.getElementById("bordervalue").value = document.getElementById("style_cornerstyle_10px").value;
		});
	});
	
	
	function src() {
		var ifadunittype = document.getElementById("adunittype").value;
		var ifadunitformat = document.getElementById("adunitformat").value;
		var ifadunittypesel = document.getElementById("adunittypesel").value;
		if(ifadunittype == 'TextAd' || ifadunittype == 'NativeAd') {
			if(ifadunittypesel != '' && ifadunittypesel != 'new'){
				var ifsizes = ifadunitformat.split("x");
				if(ifsizes[0] > 450){ document.getElementById("currentElement").height = '160px'; }
				else {	document.getElementById("currentElement").height = parseInt(ifsizes[1])+80+'px'; }
				document.getElementById("currentElement").width = '100%';
				document.getElementById("currentElement").src = '/preview/?id='+ifadunittypesel+'&size='+ifadunitformat;
			} else if (ifadunittypesel != 'new') {
				document.getElementById("currentElement").src ='';
			}
		} else if(ifadunittype == 'DisplayAd') {
			if(ifadunittypesel != '' && ifadunittypesel != 'new'){
				var ifsizes = ifadunitformat.split("x");
				if(ifsizes[0] > 450){ document.getElementById("currentElement").height = '380px'; }
				else {	document.getElementById("currentElement").height = parseInt(ifsizes[1])+80+'px'; }
				document.getElementById("currentElement").width = '100%';
				document.getElementById("currentElement").src = '/preview/?id='+ifadunittypesel+'&img='+ifadunitformat;
			} else if (ifadunittypesel != 'new') {
				document.getElementById("currentElement").src ='';
			}
		} else if(ifadunittype == 'TextAndDisplayAd') {
			if(ifadunittypesel != '' && ifadunittypesel != 'new'){
				var ifsizes = ifadunitformat.split("x");
				if(ifsizes[0] > 450){ document.getElementById("currentElement").height = '380px'; }
				else {	document.getElementById("currentElement").height = parseInt(ifsizes[1])+80+'px'; }
				document.getElementById("currentElement").width = '100%';
				document.getElementById("currentElement").src = '/preview/?id='+ifadunittypesel+'&size='+ifadunitformat+'&img='+ifadunitformat;
			} else if (ifadunittypesel != 'new') {
				document.getElementById("currentElement").src ='';
			}
		}
	}
	$( document ).ready(function() {
		$( "#adunitformat" ).change(function() {
			src();	
		});
	});
	$( document ).ready(function() {
		$( ".widget-content" ).click(function() {
			document.getElementById("nameerror").style.display = 'none';
			document.getElementById("descriptionerror").style.display = 'none';
			document.getElementById("alternateerror").style.display = 'none';
			document.getElementById("fullbackgrounderror").style.display = 'none';
			document.getElementById("devicetypeerror").style.display = 'none';
			document.getElementById("formaterror").style.display = 'none';
			document.getElementById("styleiderror").style.display = 'none';
			document.getElementById("PricingError").style.display = 'none';
			document.getElementById("nameerror").innerHTML = '';
			document.getElementById("descriptionerror").innerHTML = '';
			document.getElementById("alternateerror").innerHTML = '';
			document.getElementById("fullbackgrounderror").innerHTML = '';
			document.getElementById("devicetypeerror").innerHTML = '';
			document.getElementById("formaterror").innerHTML = '';
			document.getElementById("styleiderror").innerHTML = '';
			document.getElementById("placementerror").innerHTML = '';
			document.getElementById("PricingError").innerHTML = '';
		});

	});

	$( document ).ready(function() {
		$( "#backupads" ).change(function() {
			if(document.getElementById("backupads").value == "anotherURL"){
				document.getElementById("adunitbackupads").style.display = 'block';
				document.getElementById("adunitfullbackground").style.display = 'none';
			} else if (document.getElementById("backupads").value == "FillSpace"){
				document.getElementById("adunitfullbackground").style.display = 'block';
				document.getElementById("adunitbackupads").style.display = 'none';
			} else {
				document.getElementById("adunitfullbackground").style.display = 'none';
				document.getElementById("adunitbackupads").style.display = 'none';
			}
		});
	});
	$( document ).ready(function() {
		var backupads = document.getElementById("backupads").value;
		if(backupads == "anotherURL"){
			document.getElementById("adunitbackupads").style.display = 'block';
			document.getElementById("adunitfullbackground").style.display = 'none';
		} else if (backupads == "FillSpace"){
			document.getElementById("adunitfullbackground").style.display = 'block';
			document.getElementById("adunitbackupads").style.display = 'none';
		} else {
			document.getElementById("adunitfullbackground").style.display = 'none';
			document.getElementById("adunitbackupads").style.display = 'none';
		}
	});
	$( document ).ready(function() {
		$( "#adunittype" ).change(function() {			
			src();
		});
	});


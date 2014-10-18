/* Styles will be set here*/
/* function starts here */
function setStyle(styleValues){
	var nativeadunittypesel = $("#nativeadunittypesel").val();
	for (var k in styleValues){
		if (styleValues.hasOwnProperty(k)) {
			if (styleValues[k]["sId"] == nativeadunittypesel) {
				var sborder = styleValues[k]["border"];
				var sbackground = styleValues[k]["background"];
				var styleTempType = styleValues[k]["layoutStyle"];
				$("#NativePreview").css('border', '2px solid #' + sborder ); 
				$("#NativePreview").css('background-color', '#' + sbackground );
				$("#NativePreview").css('border-radius', styleValues[k]["cornerStyle"] );
				if (styleValues[k]["desBold"] == 1) { $("#url_Preview").css("font-weight","bold"); }
				if (styleValues[k]["desItalic"] == 1) { $("#url_Preview").css("font-style","italic"); }
				if (styleValues[k]["desUnderline"] == 1) { $("#url_Preview").css("text-decoration","underline"); }
				$("#url_Preview").css("color", styleValues[k]["desColor"]);
				$("#url_Preview").css("font-family", styleValues[k]["desFontFamily"]);
				$("#url_Preview").css("font-size", styleValues[k]["desFontSize"]);
				if (styleValues[k]["headlineBold"] == 1) { $("#headline_Preview").css("font-weight","bold"); }
				if (styleValues[k]["headlineItalic"] == 1) { $("#headline_Preview").css("font-style","italic"); }
				if (styleValues[k]["headlineUnderline"] == 1) { $("#headline_Preview").css("text-decoration","underline"); }
				$("#headline_Preview").css("color", styleValues[k]["headlineColor"]);
				$("#headline_Preview").css("font-family", styleValues[k]["headlineFontFamily"]);
				$("#headline_Preview").css("font-size", styleValues[k]["headlineFontSize"]);
				if(styleTempType == '0') {
					$("#image_preview1").show();
					$("#image_preview2").hide();
					$("#image_preview1").css({"width":"280px" , "height" : "80px"});
					$(".DnativeAdsImg").css({"width":"280px" , "height" : "80px"});
					$("#list_ul li:eq(0)").css({"float":"none"});
				} else if (styleTempType == '1') {
					$("#image_preview1").hide();
					$("#image_preview2").show();
					$("#image_preview1").css({"width":"280px" , "height" : "80px"});
					$(".DnativeAdsImg").css({"width":"280px" , "height" : "80px"});
					$("#list_ul li:eq(0)").css({"float":"none"});
				} else if (styleTempType == '2') {
					$("#image_preview1").show();
					$("#image_preview2").hide();
					$("#image_preview1").css({"width":"150px" , "height" : "80px"});
					$(".DnativeAdsImg").css({"width":"150px" , "height" : "80px"});
					$("#list_ul li:eq(0)").css({"float":"right"});
				} else if (styleTempType == '3') {
					$("#image_preview1").show();
					$("#image_preview2").hide();
					$("#image_preview1").css({"width":"150px" , "height" : "80px"});
					$(".DnativeAdsImg").css({"width":"150px" , "height" : "80px"});
					$("#list_ul li:eq(0)").css({"float":"left"});
				}
			}
		}
	}
}
/* Ends here */
$(document).ready(function(){
	$('#cpBoth').colorpicker();
	$('#cpDiv').colorpicker({ 
	color:'#31859b'
	});
	$('#ccUrl').colorpicker();
	$('#ccDiv').colorpicker({
	color:'#31859b' 
	});
});

/*
function url_preview(){
alert("url preview");
		document.getElementById("url").style.display = "inline";
		document.getElementById("headline").style.display = "none";
}
*/

/*
$("#url_Preview").click(function (e) {
	alert("url preview");
		document.getElementById("url").style.display = "inline";
		document.getElementById("headline").style.display = "none";
		return false;
	});
	*/
		
	
$(document).ready(function() {
	var fontColor = $("#cpBoth").val();
	var ccUrlfontColor = $("#ccUrl").val();
	document.getElementById("headline_Preview").style.color = fontColor;
	document.getElementById("url_Preview").style.color = ccUrlfontColor;
	$("html").click(function (e) {
		var fontColor = $("#cpBoth").val();
		var ccUrlfontColor = $("#ccUrl").val();
		document.getElementById("headline_Preview").style.color = fontColor;
		document.getElementById("url_Preview").style.color = ccUrlfontColor;
	}); 
	$(".icon-bold").click(function (e) {
		var currentId = $(this).parent().attr('id');
		var clickidPreview = currentId + "_Preview";
		var elem = document.getElementById(clickidPreview).style.fontWeight;
		if(typeof elem !== 'undefined' && elem !== null) { document.getElementById(clickidPreview).style.fontWeight = "bold"; }
		if(elem === 'bold') { document.getElementById(clickidPreview).style.fontWeight = ""; }
	});
	$(".icon-italic").click(function (e) {
		var currentId = $(this).parent().attr('id');
		var clickidPreview = currentId + "_Preview";
		var elem = document.getElementById(clickidPreview).style.fontStyle;
		if(typeof elem !== 'undefined' && elem !== null) { document.getElementById(clickidPreview).style.fontStyle = "italic"; }
		if(elem === 'italic') { document.getElementById(clickidPreview).style.fontStyle = ""; }
	});
	$(".icon-underline").click(function (e) {
		var currentId = $(this).parent().attr('id');
		var clickidPreview = currentId + "_Preview";
		var elem = document.getElementById(clickidPreview).style.textDecoration;
		if(typeof elem !== 'undefined' && elem !== null) { document.getElementById(clickidPreview).style.textDecoration = "underline"; }
		if(elem === 'underline') { document.getElementById(clickidPreview).style.textDecoration = ""; }
	});
	$( ".fontfamily" ).change(function (e) {
		var fontFamily = $(this).val();
		var currentId = $(this).parent().parent().attr('id');
		var clickidPreview = currentId + "_Preview";
		if(fontFamily == 'Font type') {
			document.getElementById(clickidPreview).style.fontFamily = '';
		} else {
			document.getElementById(clickidPreview).style.fontFamily = fontFamily;
		}
	});
	$( ".fontsize" ).change(function (e) {
		var fontsize = $(this).val();
		var currentId = $(this).parent().parent().attr('id');
		var clickidPreview = currentId + "_Preview";
		if(fontsize == 'Font size') {
			document.getElementById(clickidPreview).style.fontSize = '12px';
		} else {
			document.getElementById(clickidPreview).style.fontSize = fontsize;
		}
	});
	
	
	
	
	$( "#styleborder" ).change(function (e) {
	
		 var d = document.getElementById( 'styleborder' );

     document.getElementById("NativePreview").style.borderColor=d.style.backgroundColor;
		
	});
	
	
	
	$( "#stylebackgroud" ).change(function (e) {
		//alert("styleborder is change");
		 var d = document.getElementById( 'stylebackgroud' );
		//alert( d.style.backgroundColor );
     document.getElementById("NativePreview").style.backgroundColor=d.style.backgroundColor;
		//alert("AAAAAAAAAA");
		//alert("color"+x);
	});
	
	/*
		var disp_type = $(this).val();
		if(disp_type == "Design"){
			// NativePreview
			$("#NativePreview").show();
			$("#NativePreview_code").hide();
		} else {
			var innerHtmlDesign = $("#NativePreview").html();
			$("#NativePreview").hide();
			$("#NativePreview_code").show();
			innerHtmlDesign = "<xmp>"+ innerHtmlDesign +"</xmp>";
//			innerHtmlDesign = innerHtmlDesign.replace(/>\s+</g,'><').replace(">", ">/n");
			$("#custom_code").html(innerHtmlDesign) ;
		}
*/
/*
	$("input[name=display_type]").click(function (e) {
		var disp_type = $(this).val();
		if(disp_type == "Design"){
			// NativePreview
			$("#NativePreview").show();
			$("#NativePreview_code").hide();
		} else {
			var innerHtmlDesign = $("#NativePreview").html();
			$("#NativePreview").hide();
			$("#NativePreview_code").show();
			innerHtmlDesign = "<xmp>"+ innerHtmlDesign +"</xmp>";
			innerHtmlDesign = innerHtmlDesign.replace(/>\s+</g,'><');
			$("#custom_code").html(innerHtmlDesign) ;
		}
	});
*/
	// 
	/*
	$( ".display_type_adjust" ).change(function (e) {
	var myRadio = $('input[name=display_type]');
	var checkedValue = myRadio.filter(':checked').val();
	
	if(checkedValue=='Code'){
	//alert("code");
	var get_html1= document.getElementById('NativePreview').outerHTML;
	document.getElementById('custom_code').innerHTML= get_html1;
	$( "#NativePreview_code" ).show();
	$( "#NativePreview" ).hide();
	}
	
	if(checkedValue=='Design'){
	//alert("Design");
	var x = document.getElementById("custom_code").value;
	document.getElementById('NativePreview').outerHTML=x;
	$( "#NativePreview_code" ).hide();
	$( "#NativePreview" ).show();
	}
	
	});
	*/
	
	$( "#style_cornerstyle_0px" ).change(function (e) {
	//alert("style_cornerstyle_0px is change");
	document.getElementById('NativePreview').style.borderRadius = '0em'; // w3c
	document.getElementById('NativePreview').style.MozBorderRadius = '0em'; // mozilla
	});
	
	
	$( "#style_cornerstyle_6px" ).change(function (e) {
	//alert("style_cornerstyle_6px is change");
	document.getElementById('NativePreview').style.borderRadius = '0.5em'; // w3c
	document.getElementById('NativePreview').style.MozBorderRadius = '0.5em'; // mozilla
	
	});
	
	$( "#style_cornerstyle_10px" ).change(function (e) {
	//alert("style_cornerstyle_10px is change");
	document.getElementById('NativePreview').style.borderRadius = '0.8em'; // w3c
	document.getElementById('NativePreview').style.MozBorderRadius = '0.8em'; // mozilla
	
	});
	
	
	$(document).click(function(e){
		if( $(e.target).closest("#headline").length > 0 ) { return false; }
		if( $(e.target).closest("#url").length > 0 ) { return false; }
		if(document.getElementById("url").style.display == 'inline') { document.getElementById("url").style.display = "none"; }
		if(document.getElementById("headline").style.display == 'inline') { document.getElementById("headline").style.display = "none"; }
	});
});
	var One = {
		"175x100":"175 x 100",
		"150x60":"150 x 60",
		"70x70":"70 x 70",
		"80x80":"80 x 80",
	};
	var Two = {
		"470x80":"470 x 80",
		"300x80":"300 x 80",
		"200x80":"200 x 80",
		"80x80":"80 x 80",
	};
	var Three = {
		"225x375":"225 x 375",
		"75x75":"75 x 75",
		"100x100":"100 x 100",
		"80x80":"80 x 80",
	};
	var Four = {
		"300x30":"300 x 30",
	};
	var Five = {
		"":"Create Img Format",
	};
	$( document ).ready(function() {

/* On Click of div of radio button */
/* Starts here */
		$( "#inner_adtype_textad" ).click(function() {
			document.getElementById("adunit_adtype_TextAd").checked = 'true'
			document.getElementById("adunittype").value = "TextAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			$('#adunittypesel').prop('disabled', false);
			$('#divadunittypesel').show();
			$('#currentElement').show();
			$(".third").addClass("show");
			$(".sectionPreview").hide();
			$("#NativePreview").hide();
src();
		});
		$( "#inner_adtype_displayad" ).click(function() {
			document.getElementById("adunit_adtype_DisplayAd").checked = 'true'
			document.getElementById("adunittype").value = "DisplayAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			$('#adunittypesel').prop('disabled', true);
			$('#divadunittypesel').hide();
			$('#currentElement').show();
			$(".third").addClass("show");
			$(".sectionPreview").hide();
			$("#NativePreview").hide();
src();
		});
		$( "#inner_adtype_textanddisplayad" ).click(function() {
			document.getElementById("adunit_adtype_TextAndDisplayAd").checked = 'true'
			document.getElementById("adunittype").value = "TextAndDisplayAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			$('#adunittypesel').prop('disabled', false);
			$('#divadunittypesel').show();
			$('#currentElement').show();
			$(".third").addClass("show");
			$(".sectionPreview").hide();
			$("#NativePreview").hide();
src();
		});
		$( "#inner_adtype_nativead" ).click(function() {
			document.getElementById("adunit_adtype_NativeAd").checked = 'true'
			document.getElementById("adunittype").value = "NativeAd";
			$(".second").addClass("show"); 
			$(".first").removeClass("show");
			$('#currentElement').hide();
			$('.sectionPreview').hide();
			$('#nativeads_step1').show();
			$('#nativeads_step2').hide();
			$(".third").removeClass("show");
			$("#NativePreview").show();
src();
		});
/* Ends here */

		if ($("#adunit_adtype_TextAd").is(":checked")) {
			document.getElementById("adunittype").value = "TextAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			$('#adunittypesel').prop('disabled', false);
			$('#divadunittypesel').show();
			$('#currentElement').show();
			$(".third").addClass("show");
			$(".sectionPreview").hide();
			$("#NativePreview").hide();
		}
		if ($("#adunit_adtype_DisplayAd").is(":checked")) {
			document.getElementById("adunittype").value = "DisplayAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			$('#adunittypesel').prop('disabled', true);
			$('#divadunittypesel').hide();
			$('#currentElement').show();
			$(".third").addClass("show");
			$(".sectionPreview").hide();
			$("#NativePreview").hide();
		}
		if ($("#adunit_adtype_TextAndDisplayAd").is(":checked")) {
			document.getElementById("adunittype").value = "TextAndDisplayAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			$('#adunittypesel').prop('disabled', false);
			$('#divadunittypesel').show();
			$('#currentElement').show();
			$(".third").addClass("show");
			$(".sectionPreview").hide();
			$("#NativePreview").hide();
		}
		if ($("#adunit_adtype_NativeAd").is(":checked")) {
			document.getElementById("adunittype").value = "NativeAd";
			$(".second").addClass("show"); 
			$(".first").removeClass("show");
			$('#currentElement').hide();
			var selectedStyleValue = $("#selectedStyle").val();
			if(selectedStyleValue == "") {
				$('#nativeads_step1').show();
				$('#nativeads_step2').hide();
				$(".third").removeClass("show");
				$("#NativePreview").show();
				$('.sectionPreview').hide();
			} else {
				$('#nativeads_step1').show();
				$('#nativeads_step2').hide();
				$("#"+selectedStyleValue).addClass("nativeAdStyleSelect");
				$(".third").removeClass("show");
				$('.sectionPreview').hide();
				$('#nextStep').prop('disabled', false);
				// $("#NativePreview").show();
				setStyle(styleValues);
			}
		}
		$( "#adunit_adtype_TextAd" ).click(function() {
			document.getElementById("adunit_adtype_TextAd").checked = 'true'
			document.getElementById("adunittype").value = "TextAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			$('#adunittypesel').prop('disabled', false);
			$('#divadunittypesel').show();
			$('#currentElement').show();
			$(".third").addClass("show");
			$(".sectionPreview").hide();
			$("#NativePreview").hide();
src();
		});
		$( "#adunit_adtype_DisplayAd" ).click(function() {
			document.getElementById("adunit_adtype_DisplayAd").checked = 'true'
			document.getElementById("adunittype").value = "DisplayAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			$('#adunittypesel').prop('disabled', true);
			$('#divadunittypesel').hide();
			$('#currentElement').show();
			$(".third").addClass("show");
			$(".sectionPreview").hide();
			$("#NativePreview").hide();
src();
		});
		$( "#adunit_adtype_TextAndDisplayAd" ).click(function() {
			document.getElementById("adunit_adtype_TextAndDisplayAd").checked = 'true'
			document.getElementById("adunittype").value = "TextAndDisplayAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			$('#adunittypesel').prop('disabled', false);
			$('#divadunittypesel').show();
			$('#currentElement').show();
			$(".third").addClass("show");
			$(".sectionPreview").hide();
			$("#NativePreview").hide();
src();
		});
		$( "#adunit_adtype_NativeAd" ).click(function() {
			document.getElementById("adunit_adtype_NativeAd").checked = 'true'
			document.getElementById("adunittype").value = "NativeAd";
			$(".second").addClass("show"); 
			$(".first").removeClass("show");
			$('#currentElement').hide();
			$('.sectionPreview').hide();
			$('#nativeads_step1').show();
			$('#nativeads_step2').hide();
			$(".third").removeClass("show");
			$("#NativePreview").show();
src();
		});
		$( ".layout-type-class" ).click(function() {
			$(".layout-type-class").removeClass("selected");
			$(this).addClass("selected");
			var firstimg = $(this).find('img:first').attr('src');
			//alert(firstimg);
			if(firstimg=='/assets/template.png')
			{
			//alert("image-11");
			 $("#image_preview1").show();
			 $("#image_preview2").hide();
			 $("#TempStyle").val("1");
			document.getElementById("image_preview1").style.cssFloat="none";
			document.getElementById("image_preview2").style.cssFloat="none";
			}
			if(firstimg=='/assets/template1.png')
			{
			//alert("image-22");
			 $("#TempStyle").val("2");
			 $("#image_preview1").hide();
			  $("#image_preview2").show();
			//document.getElementById("image_preview1").style.cssFloat="none";
			document.getElementById("image_preview2").style.cssFloat="none";
			}
			if(firstimg=='/assets/template2.png')
			{
			 $("#TempStyle").val("3");
			//alert("image-33");
			 $("#image_preview1").show();
			 $("#image_preview2").hide();
			document.getElementById("image_preview1").style.cssFloat="right";
			}
			if(firstimg=='/assets/template3.png')
			{
			 $("#TempStyle").val("4");
			//alert("image-44");
			 $("#image_preview1").show();
			 $("#image_preview2").hide();
			document.getElementById("image_preview1").style.cssFloat="left";
			}
			
			
			document.getElementById("NativeAdImg").value = firstimg;
			changeNativeAdDisplay();
			return false;
		});
		var format = {};
		if(document.getElementById("tempFormat").value == "300x155"){
			document.getElementById("imgFormat").disabled = false;
			var format = One;
		} else if (document.getElementById("tempFormat").value == "470x80"){
			document.getElementById("imgFormat").disabled = false;
			var format = Two;
		} else if (document.getElementById("tempFormat").value == "225x375"){
			document.getElementById("imgFormat").disabled = false;
			var format = Three;
		} else if (document.getElementById("tempFormat").value == "300x30"){
			document.getElementById("imgFormat").disabled = false;
			var format = Four;
		} else if (document.getElementById("tempFormat").value == "Create"){
			document.getElementById("imgFormat").disabled = true;
			var format = Five;
		} else {
			document.getElementById("imgFormat").disabled = true;
		}
			document.getElementById("imgFormat").options.length = 0;
			if (document.getElementById("tempFormat").value != "Create") {
				$('<option value="">- Select a Format -</option>').appendTo('#imgFormat');
			}
		for(var item in format){
			$('<option value="'+item+'">'+format[item]+'</option>').appendTo('#imgFormat');
		}
			var tempFormat = document.getElementById("tempFormat").value;
			if(tempFormat == "") {
				$("#TemplateformatTable").hide();
				$("#imageFormatTable").hide();
			} else if (tempFormat == "Create") {
				$("#TemplateformatTable").show();
				$("#imageFormatTable").show();
				document.getElementById("NativePreview").style.width = "300px";
				document.getElementById("NativePreview").style.height = "200px";
			} else {
				$("#TemplateformatTable").hide();
				$("#imageFormatTable").hide();
				tempsizes = tempFormat.split("x");
				previewwidth = tempsizes[0] + "px";
				previewheight = tempsizes[1] + "px";
				document.getElementById("NativePreview").style.width = previewwidth;
				document.getElementById("NativePreview").style.height = previewheight;
			}
	});

	$( document ).ready(function() {
			var nativeAdTempWidth = $( "input[name='adunit[nativeAdTempWidth]']" ).val();
			if(isNaN(nativeAdTempWidth)) {
				document.getElementById("TempError").innerHTML = "Not a valid width";
				document.getElementById("TempError").style.display = "inline";
				return false;
			} else {
				document.getElementById("NativePreview").style.width = nativeAdTempWidth+"px";
			}
			var nativeAdTempHeight = $( "input[name='adunit[nativeAdTempHeight]']" ).val();
			if(isNaN(nativeAdTempHeight)) {
				document.getElementById("TempError").innerHTML = "Not a valid height";
				document.getElementById("TempError").style.display = "inline";
				return false;
			} else {
				document.getElementById("NativePreview").style.height = nativeAdTempHeight+"px";
			}
			var nativeAdImgWidth = $( "input[name='adunit[nativeAdImgWidth]']" ).val();
			if(isNaN(nativeAdImgWidth)) {
				document.getElementById("ImgError").innerHTML = "Not a valid width";
				document.getElementById("ImgError").style.display = "inline";
				return false;
			} else {
				document.getElementById("image_preview1").style.width = nativeAdImgWidth+"px";
				document.getElementById("sample_img1").style.width = nativeAdImgWidth+"px";
				document.getElementById("image_preview2").style.width = nativeAdImgWidth+"px";
				document.getElementById("sample_img2").style.width = nativeAdImgWidth+"px";
			}
			var nativeAdImgHeight = $( "input[name='adunit[nativeAdImgHeight]']" ).val();
			if(isNaN(nativeAdImgHeight)) {
				document.getElementById("ImgError").innerHTML = "Not a valid height";
				document.getElementById("ImgError").style.display = "inline";
				return false;
			} else {
				document.getElementById("sample_img1").style.height = nativeAdImgHeight+"px";
				document.getElementById("image_preview1").style.height = nativeAdImgHeight+"px";
				document.getElementById("sample_img2").style.height = nativeAdImgHeight+"px";
				document.getElementById("image_preview2").style.height = nativeAdImgHeight+"px";
			}
		$( "input[name='adunit[nativeAdTempWidth]']" ).change(function() {
			var nativeAdTempWidth = $( "input[name='adunit[nativeAdTempWidth]']" ).val();
			if(isNaN(nativeAdTempWidth)) {
				document.getElementById("TempError").innerHTML = "Not a valid width";
				document.getElementById("TempError").style.display = "inline";
				return false;
			} else {
				document.getElementById("NativePreview").style.width = nativeAdTempWidth+"px";
			}
		});
		$( "input[name='adunit[nativeAdTempHeight]']" ).change(function() {
			var nativeAdTempHeight = $( "input[name='adunit[nativeAdTempHeight]']" ).val();
			if(isNaN(nativeAdTempHeight)) {
				document.getElementById("TempError").innerHTML = "Not a valid height";
				document.getElementById("TempError").style.display = "inline";
				return false;
			} else {
				document.getElementById("NativePreview").style.height = nativeAdTempHeight+"px";
			}
		});
		$( "input[name='adunit[nativeAdImgWidth]']" ).change(function() {
			var nativeAdImgWidth = $( "input[name='adunit[nativeAdImgWidth]']" ).val();
			if(isNaN(nativeAdImgWidth)) {
				document.getElementById("ImgError").innerHTML = "Not a valid width";
				document.getElementById("ImgError").style.display = "inline";
				return false;
			} else {
				document.getElementById("sample_img1").style.width = nativeAdImgWidth+"px";
				document.getElementById("image_preview1").style.width = nativeAdImgWidth+"px";
				document.getElementById("sample_img2").style.width = nativeAdImgWidth+"px";
				document.getElementById("image_preview2").style.width = nativeAdImgWidth+"px";
			}
		});
		$( "input[name='adunit[nativeAdImgHeight]']" ).change(function() {
			var nativeAdImgHeight = $( "input[name='adunit[nativeAdImgHeight]']" ).val();
			if(isNaN(nativeAdImgHeight)) {
				document.getElementById("ImgError").innerHTML = "Not a valid height";
				document.getElementById("ImgError").style.display = "inline";
				return false;
			} else {
				document.getElementById("sample_img1").style.height = nativeAdImgHeight+"px";
				document.getElementById("image_preview1").style.height = nativeAdImgHeight+"px";
				document.getElementById("sample_img2").style.height = nativeAdImgHeight+"px";
				document.getElementById("image_preview2").style.height = nativeAdImgHeight+"px";
			}
		});
	});
	$( document ).ready(function() {
		$( "#tempFormat" ).change(function() {
			var tempFormat = document.getElementById("tempFormat").value;
			if(tempFormat == "") {
				$("#TemplateformatTable").hide();
				$("#imageFormatTable").hide();
			} else if (tempFormat == "Create") {
				$("#TemplateformatTable").show();
				$("#imageFormatTable").show();
				document.getElementById("NativePreview").style.width = "300px";
				document.getElementById("NativePreview").style.height = "200px";
			} else {
				$("#TemplateformatTable").hide();
				$("#imageFormatTable").hide();
				tempsizes = tempFormat.split("x");
				previewwidth = tempsizes[0] + "px";
				previewheight = tempsizes[1] + "px";
				document.getElementById("NativePreview").style.width = previewwidth;
				document.getElementById("NativePreview").style.height = previewheight;
			}
			if(document.getElementById("tempFormat").value == "300x155"){
				document.getElementById("imgFormat").disabled = false;
				document.getElementById("TemplateformatTable").style.display = "none";
				var format = One;
			} else if (document.getElementById("tempFormat").value == "470x80"){
				document.getElementById("imgFormat").disabled = false;
				document.getElementById("TemplateformatTable").style.display = "none";
				var format = Two;
			} else if (document.getElementById("tempFormat").value == "225x375"){
				document.getElementById("imgFormat").disabled = false;
				document.getElementById("TemplateformatTable").style.display = "none";
				var format = Three;
			} else if (document.getElementById("tempFormat").value == "300x30"){
				document.getElementById("imgFormat").disabled = false;
				document.getElementById("TemplateformatTable").style.display = "none";
				var format = Four;
			} else if (document.getElementById("tempFormat").value == "Create"){
				document.getElementById("imgFormat").disabled = true;
				document.getElementById("TemplateformatTable").style.display = "inline-table";
				var format = Five;
			} else {
				document.getElementById("imgFormat").disabled = true;
			}
			document.getElementById("imgFormat").options.length = 0;
			if (document.getElementById("tempFormat").value != "Create") {
				$('<option value="">- Select a Format -</option>').appendTo('#imgFormat');
			}
			for(var item in format)
			{
				$('<option value="'+item+'">'+format[item]+'</option>').appendTo('#imgFormat');
			}
		});
		
		
		
			$( "#imgFormat" ).change(function() {
				var tempFormat = document.getElementById("imgFormat").value;
				//alert("now change...!!!!"+tempFormat);
				if(tempFormat!=''){
					tempsizes = tempFormat.split("x");
					//alert(tempsizes[0]+"===="+tempsizes[1]);
					previewwidth = tempsizes[0] + "px";
					previewheight = tempsizes[1] + "px";
					document.getElementById("sample_img1").style.width = previewwidth;
					document.getElementById("sample_img1").style.height = previewheight;
					document.getElementById("sample_img2").style.width = previewwidth;
					document.getElementById("sample_img2").style.height = previewheight;
					document.getElementById("image_preview1").style.width = previewwidth;
					document.getElementById("image_preview1").style.height = previewheight;
					document.getElementById("image_preview2").style.width = previewwidth;
					document.getElementById("image_preview2").style.height = previewheight;
				}
			});
			
	/*	
$("#url_Preview").click(function (e) {
	alert("url preview");
		document.getElementById("url").style.display = "inline";
		document.getElementById("headline").style.display = "none";
		return false;
	});
	
	*/
	
	/*
	$("#url_Preview").click(function (e) {
	alert("url preview");
		
	});
	*/	
		
	});
	
	
	function head_preview11(){
	//alert("hiii");
 $("#headline").toggle();
}
	
	function url_preview11(){
	//alert("hiii");
 $("#url").toggle();
}	
	
	

function changeNativeAdDisplay(){
	
}

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
$( document ).ready(function() {
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
	$("#url_Preview").click(function (e) {
		document.getElementById("url").style.display = "inline";
		document.getElementById("headline").style.display = "none";
		return false;
	});
	$("#headline_Preview").click(function (e) {
		document.getElementById("headline").style.display = "inline";
		document.getElementById("url").style.display = "none";
		return false;
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
	$( document ).ready(function() {
		if ($("#adunit_adtype_TextAd").is(":checked")) {
			document.getElementById("adunittype").value = "TextAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			document.getElementById("NativePreview").style.display = "none";
		}
		if ($("#adunit_adtype_DisplayAd").is(":checked")) {
			document.getElementById("adunittype").value = "DisplayAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			document.getElementById("NativePreview").style.display = "none";
		}
		if ($("#adunit_adtype_TextAndDisplayAd").is(":checked")) {
			document.getElementById("adunittype").value = "TextAndDisplayAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			document.getElementById("NativePreview").style.display = "none";
		}
		if ($("#adunit_adtype_NativeAd").is(":checked")) {
			document.getElementById("adunittype").value = "NativeAd";
			$(".second").addClass("show");
			$(".first").removeClass("show");
			document.getElementById("NativePreview").style.display = "inline-block";
		}
		$( "#adunit_adtype_TextAd" ).click(function() {
			document.getElementById("adunittype").value = "TextAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			document.getElementById("NativePreview").style.display = "none";
		});
		$( "#adunit_adtype_DisplayAd" ).click(function() {
			document.getElementById("adunittype").value = "DisplayAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			document.getElementById("NativePreview").style.display = "none";
		});
		$( "#adunit_adtype_TextAndDisplayAd" ).click(function() {
			document.getElementById("adunittype").value = "TextAndDisplayAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			document.getElementById("NativePreview").style.display = "none";
		});
		$( "#adunit_adtype_NativeAd" ).click(function() {
			document.getElementById("adunittype").value = "NativeAd";
			$(".second").addClass("show");
			$(".first").removeClass("show");
			document.getElementById("NativePreview").style.display = "inline-block";
		});
		$( "#inner_adtype_textad" ).click(function() {
			document.getElementById("adunit_adtype_TextAd").checked = 'true'
			document.getElementById("adunittype").value = "TextAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			document.getElementById("NativePreview").style.display = "none";
		});
		$( "#inner_adtype_displayad" ).click(function() {
			document.getElementById("adunit_adtype_DisplayAd").checked = 'true'
			document.getElementById("adunittype").value = "DisplayAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			document.getElementById("NativePreview").style.display = "none";
		});
		$( "#inner_adtype_textanddisplayad" ).click(function() {
			document.getElementById("adunit_adtype_TextAndDisplayAd").checked = 'true'
			document.getElementById("adunittype").value = "TextAndDisplayAd";
			$(".first").addClass("show");
			$(".second").removeClass("show");
			document.getElementById("NativePreview").style.display = "none";
		});
		$( "#inner_adtype_nativead" ).click(function() {
			document.getElementById("adunit_adtype_NativeAd").checked = 'true'
			document.getElementById("adunittype").value = "NativeAd";
			$(".second").addClass("show");
			$(".first").removeClass("show");
			document.getElementById("NativePreview").style.display = "inline-block";
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
			document.getElementById("image_preview1").style.cssFloat="none";
			document.getElementById("image_preview2").style.cssFloat="none";
			}
			if(firstimg=='/assets/template1.png')
			{
			//alert("image-22");
			 $("#image_preview1").hide();
			  $("#image_preview2").show();
			//document.getElementById("image_preview1").style.cssFloat="none";
			document.getElementById("image_preview2").style.cssFloat="none";
			}
			if(firstimg=='/assets/template2.png')
			{
			//alert("image-33");
			 $("#image_preview1").show();
			 $("#image_preview2").hide();
			document.getElementById("image_preview1").style.cssFloat="right";
			}
			if(firstimg=='/assets/template3.png')
			{
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
			document.getElementById("TemplateformatTable").style.display = "inline-table";
		} else {
			document.getElementById("imgFormat").disabled = true;
		}
		document.getElementById("imgFormat").options.length = 0;
		$('<option value="">-Select a Format-</option>').appendTo('#imgFormat');
		for(var item in format)
		{
			$('<option value="'+item+'">'+format[item]+'</option>').appendTo('#imgFormat');
		}
	});

	$( document ).ready(function() {
		$( "#tempFormat" ).change(function() {
			var tempFormat = document.getElementById("tempFormat").value;
			if(tempFormat == "Create" || tempFormat == "") {
			} else {
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
			} else {
				document.getElementById("imgFormat").disabled = true;
			}
			document.getElementById("imgFormat").options.length = 0;
			$('<option value="">- Select a Format -</option>').appendTo('#imgFormat');
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
			}
			
			
			});
		
		
		
		
		
	});
	
	
	
	
	

function changeNativeAdDisplay(){
	
}

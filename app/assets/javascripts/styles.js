function changeNativeAdDisplay() {
	var stylebackground_nativead = $("#stylebackground_nativead").val();
	var styleborder_nativead = $("#styleborder_nativead").val();
	var cornerstyle_nativeads = $("input:radio[name='style[cornerstyle_nativead]']:checked").val();
	var styleTempType = $("#styleTempType").val();
	var headline_nativeadsbold = $("#headline_nativeadsbold").val();
	var headline_nativeadscolor = $("#headline_nativeadscolor").val();
	var headline_nativeadsfontfamily = $("#headline_nativeadsfontfamily").val();
	var headline_nativeadsfontsize = $("#headline_nativeadsfontsize").val();
	var headline_nativeadsitalic = $("#headline_nativeadsitalic").val();
	var headline_nativeadsunderline = $("#headline_nativeadsunderline").val(); 
	var description_nativeadsbold = $("#description_nativeadsbold").val();
	var description_nativeadscolor = $("#description_nativeadscolor").val();
	var description_nativeadsfontfamily = $("#description_nativeadsfontfamily").val();
	var description_nativeadsfontsize = $("#description_nativeadsfontsize").val();
	var description_nativeadsitalic = $("#description_nativeadsitalic").val();
	var description_nativeadsunderline = $("#description_nativeadsunderline").val();

	$(".nativeAds-preview").css("background-color","#"+stylebackground_nativead);
	$(".nativeAds-preview").css('border', '1px solid #'+styleborder_nativead);
	$(".nativeAds-preview").css("border-radius", cornerstyle_nativeads);

	if (headline_nativeadscolor != 'none') {	$(".headline_nativeads").css("color", headline_nativeadscolor); }
	if(headline_nativeadsfontfamily != 'none') {	$(".headline_nativeads").css("font-family", headline_nativeadsfontfamily); } 
	if(headline_nativeadsfontsize != 'none') { 	$(".headline_nativeads").css("font-size", headline_nativeadsfontsize); }
	if(description_nativeadscolor != 'none'){	$(".description_nativeads").css("font-color", description_nativeadscolor); }
	if(description_nativeadsfontfamily != 'none'){	$(".description_nativeads").css("font-family", description_nativeadsfontfamily);  }
	if(description_nativeadsfontsize != 'none') {	$(".description_nativeads").css("font-size", description_nativeadsfontsize); }

	if (headline_nativeadsbold == '1') { $(".headline_nativeads").css("font-weight","bold"); }
	else { $(".headline_nativeads").css("font-weight",""); }
	if (headline_nativeadsitalic == '1') { $(".headline_nativeadsitalic").css("font-style","italic"); }
	else { $(".headline_nativeads").css("font-style",""); }
	if (headline_nativeadsunderline == '1') { $(".headline_nativeads").css("text-decoration","underline"); }
	else { $(".headline_nativeads").css("text-decoration",""); }

	if (description_nativeadsbold == '1') { $(".description_nativeads").css("font-weight","bold"); }
	else { $(".description_nativeads").css("text-decoration",""); }
	if (description_nativeadsitalic == '1') { $(".description_nativeads").css("font-style","italic"); }
	else { $(".description_nativeads").css("font-style",""); }
	if (description_nativeadsunderline == '1') { $(".description_nativeads").css("text-decoration","underline"); }
	else { $(".description_nativeads").css("text-decoration",""); }
	if(styleTempType == '0') {
		$(".layout-type-class").removeClass("selected");
		$('.template-placeholder div:eq('+ styleTempType +')').addClass("selected");
		$(".nativeAdsUl li:eq(0)").show();
		$(".nativeAdsUl li:eq(2)").hide();
		$(".nativeAdsImg").css({"width":"280px" , "height" : "100px"});
		$(".nativeAdsUl li:eq(0)").css({"float":"none"});
	} else if (styleTempType == '1') {
		$(".layout-type-class").removeClass("selected");
		$('.template-placeholder div:eq('+ styleTempType +')').addClass("selected");
		$(".nativeAdsUl li:eq(0)").hide();
		$(".nativeAdsUl li:eq(2)").show();
		$(".nativeAdsImg").css({"width":"280px" , "height" : "100px"});
		$(".nativeAdsUl li:eq(0)").css({"float":"none"});
	} else if (styleTempType == '2') {
		$(".layout-type-class").removeClass("selected");
		$('.template-placeholder div:eq('+ styleTempType +')').addClass("selected");
		$(".nativeAdsUl li:eq(0)").show();
		$(".nativeAdsUl li:eq(2)").hide();
		$(".nativeAdsImg").css({"width":"150px" , "height" : "80px"});
		$(".nativeAdsUl li:eq(0)").css({"float":"right"});
	} else if (styleTempType == '3') {
		$(".layout-type-class").removeClass("selected");
		$('.template-placeholder div:eq('+ styleTempType +')').addClass("selected");
		$(".nativeAdsUl li:eq(0)").show();
		$(".nativeAdsUl li:eq(2)").hide();
		$(".nativeAdsImg").css({"width":"150px" , "height" : "80px"});
		$(".nativeAdsUl li:eq(0)").css({"float":"left"});
	} else if (styleTempType == '4') {
		$(".layout-type-class").removeClass("selected");
		$('.template-placeholder div:eq('+ styleTempType +')').addClass("selected");
		$(".nativeAdsUl li:eq(0)").hide();
		$(".nativeAdsUl li:eq(2)").hide();
	}
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

$( ".layout-type-class" ).click(function() {
			$(".layout-type-class").removeClass("selected");
			$(this).addClass("selected");
			var firstimg = $(this).find('img:first').attr('src');
			var styleTempType = $(this).index();
			$("#styleTempType").val(styleTempType);
			changeNativeAdDisplay();
			return false;
		});
	});

	$( document ).ready(function() {
		$( ".widget-content" ).click(function() {
			document.getElementById("preview").style.display = "block";
			document.getElementById("preview").style.borderColor = document.getElementById("styleborder").style.backgroundColor;;
			document.getElementById("preview").style.borderStyle = 'solid';
			document.getElementById("preview").style.borderWidth = '1px';
			document.getElementById("preview").style.borderRadius = document.getElementById("bordervalue").value;
			document.getElementById("headlinepreview").style.color = document.getElementById("styletitle").style.backgroundColor;
			document.getElementById("description").style.color = document.getElementById("styletext").style.backgroundColor;
			document.getElementById("Urlpreview").style.color = document.getElementById("styleurl").style.backgroundColor;
			document.getElementById("preview").style.backgroundColor = document.getElementById("stylebackground").style.backgroundColor;
			document.getElementById("headlinepreview").style.fontFamily=document.getElementById("stylefontfamily").style.fontFamily;
			document.getElementById("preview").style.fontFamily = document.getElementById("stylefontfamily").value;
			document.getElementById("headlinepreview").style.fontSize = "medium";
			document.getElementById("Urlpreview").style.fontSize = "small";
			document.getElementById("description").style.fontSize = "small";
			document.getElementById("descriptionpreview").style.fontSize = "small";

		});
	});

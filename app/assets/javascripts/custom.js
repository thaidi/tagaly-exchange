$(function () {
	
	// CSS tweaks
	$('header nav li:last').addClass('nobg');
	$('section_head ul').each(function() { $('li:first', this).addClass('nobg'); });
	$('section form input[type=file]').addClass('file');
			
			
	
	// Check / uncheck all checkboxes
	$('.check_all').click(function() {
		$(this).parents('form').find('input:checkbox').attr('checked', $(this).is(':checked'));   
	});

	// Messages
	$('section .message .close').live('hover',
		function() { $(this).addClass('hover'); },
		function() { $(this).removeClass('hover'); }
	);
		
	$('section .message .close').live('click', function() {
		$(this).parent().fadeOut('slow', function() { $(this).remove(); });
	});
	
	
	
	
	
	
	// Tabs
	$(".tab_content").hide();
	$("ul.tabs li:first-child").addClass("active").show();
	$("section").find(".tab_content:first").show();

	$("ul.tabs li").click(function() {
		$(this).parent().find('li').removeClass("active");
		$(this).addClass("active");
		$(this).parents('section').find(".tab_content").hide();
			
		var activeTab = $(this).find("a").attr("href");
		$(activeTab).show();
		
		return false;
	});
	
	
	
	// Sidebar Tabs
	$(".sidebar_content").hide();
	
	if(window.location.hash && window.location.hash.match('sb')) {
	
		$("ul.sidemenu li a[href="+window.location.hash+"]").parent().addClass("active").show();
		$("section .sidebar_content#"+window.location.hash).show();
	} else {
	
		$("ul.sidemenu li:first-child").addClass("active").show();
		$("section .sidebar_content:first").show();
	}

	$("ul.sidemenu li").click(function() {
	
		var activeTab = $(this).find("a").attr("href");
		window.location.hash = activeTab;
	
		$(this).parent().find('li').removeClass("active");
		$(this).addClass("active");
		$(this).parents('section').find(".sidebar_content").hide();			
		$(activeTab).show();
		return false;
	});	
	
	
	
	// Block search
	$('section section_head form .text').bind('click', function() { $(this).attr('value', ''); });
	
	

	// Date picker
	$('input.date_picker').datepicker({ dateFormat : "yy-mm-dd"});
	


	// Navigation dropdown fix for IE6
	if(jQuery.browser.version.substr(0,1) < 7) {
		$('header nav li').hover(
			function() { $(this).addClass('iehover'); },
			function() { $(this).removeClass('iehover'); }
		);
	}
});


function stripTags(string, tag) {
    var tagMatcher = new RegExp('</?' + tag + '>','g');
    return string.replace(tagMatcher, '');
}


$('.download').click(function() {
	$('#'+$(this).attr('rel')).table2CSV()
});

// Form select styling
$("form select.styled").select_skin();

// Developer Tracking
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-38865805-1']);
_gaq.push(['_trackPageview']);
(function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();

// HubSpot Tracking
(function(d,s,i,r) {
    if (d.getElementById(i)){return;}
    var n=d.createElement(s),e=d.getElementsByTagName(s)[0];
    n.id=i;n.src='//js.hubspot.com/analytics/'+(Math.ceil(new Date()/r)*r)+'/239330.js';
    e.parentNode.insertBefore(n, e);
})(document,"script","hs-analytics",300000);

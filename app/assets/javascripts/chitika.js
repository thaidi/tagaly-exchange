jQuery(function($){
  $(document).ready(function(){
	  
	//alert('Locked and loaded!');
	
	// 
	// $('#block-user-login #edit-name, #block-user-login #edit-pass').after('<a href="#">Forgot</a>');
	
	// Loop through each row and match column heights
	
//	i = 1;
//	
//	$('.panels-flexible-row').each(function() {
//		
//		var maxHeight = -1;
//		
//		$('.panels-flexible-row:nth-child(' + i + ') .panel-pane').each(function() {
//			maxHeight = maxHeight > $('.panels-flexible-row:nth-child(' + i + ') .panel-pane').height() ? maxHeight : $('.panels-flexible-row:nth-child(' + i + ') .panel-pane').height();
//		});
//		$('.panels-flexible-row:nth-child(' + i + ') .panel-pane').each(function() {
//			// $('.panels-flexible-row:nth-child(' + i + ') .panel-pane').height(maxHeight);
//		});
//		
//		//alert('max height: ' + maxHeight + "\n" + i);
//		
//		i = i+1;
//		
//	});
	
	
	$(window).load(function(){
		// these are (ruh-roh) globals. You could wrap in an
		// immediately-Invoked Function Expression (IIFE) if you wanted to...
		var currentTallest = 0,
		    currentRowStart = 0,
		    rowDivs = new Array();
		
		function setConformingHeight(el, newHeight) {
			// set the height to something new, but remember the original height in case things change
			el.data("originalHeight", (el.data("originalHeight") == undefined) ? (el.height()) : (el.data("originalHeight")));
			el.height(newHeight);
		}
		
		function getOriginalHeight(el) {
			// if the height has changed, send the originalHeight
			return (el.data("originalHeight") == undefined) ? (el.height()) : (el.data("originalHeight"));
		}
		
		function columnConform() {
		
			// find the tallest DIV in the row, and set the heights of all of the DIVs to match it.
			$('.panels-flexible-row .panel-pane').each(function() {
			
				// "caching"
				var $el = $(this);
				
				var topPosition = $el.position().top;
		
				if (currentRowStart != topPosition) {
		
					// we just came to a new row.  Set all the heights on the completed row
					for(currentDiv = 0 ; currentDiv < rowDivs.length ; currentDiv++) setConformingHeight(rowDivs[currentDiv], currentTallest);
		
					// set the variables for the new row
					rowDivs.length = 0; // empty the array
					currentRowStart = topPosition;
					currentTallest = getOriginalHeight($el);
					rowDivs.push($el);
		
				} else {
		
					// another div on the current row.  Add it to the list and check if it's taller
					rowDivs.push($el);
					currentTallest = (currentTallest < getOriginalHeight($el)) ? (getOriginalHeight($el)) : (currentTallest);
		
				}
				// do the last row
				for (currentDiv = 0 ; currentDiv < rowDivs.length ; currentDiv++) setConformingHeight(rowDivs[currentDiv], currentTallest);
		
			});
		
		}
		
		
		$(window).resize(function() {
			columnConform();
		});
		
		// Dom Ready
		// You might also want to wait until window.onload if images are the things that
		// are unequalizing the blocks
		$(function() {
			columnConform();
		});
	
	});
	
	
	// Make all Font Awesome elements white on hover
	$('#navigation #main-menu .menu > li').each(function() {
		$(this).mouseover(function(){
			$(this).find('a i').css('color', '#fff');
		}).mouseout(function(){
		  	$(this + ':not(active)').find('a i').css('color', '#aaa');
		});

	});
	
	// Add font awesome classes to navigation
	publishers = '<i class="icon-laptop"></i>';
    $("#navigation #main-menu > .menu > li:nth-child(1) > a").prepend(publishers);
	
	advertisers = '<i class="icon-money"></i>';
	$("#navigation #main-menu > .menu > li:nth-child(2) > a").prepend(advertisers); 

	rtb = '<i class="icon-bullseye"></i>';
	$("#navigation #main-menu > .menu > li:nth-child(3) > a").prepend(rtb);

	mobile = '<i class="icon-mobile-phone"></i>';
	$("#navigation #main-menu > .menu > li:nth-child(4) > a").prepend(mobile); 
	
	insights = '<i class="icon-bar-chart"></i>';
	$("#navigation #main-menu > .menu > li:nth-child(5) > a").prepend(insights); 
	
	careers = '<i class="icon-trophy"></i>';
	$("#navigation #main-menu > .menu > li:nth-child(6) > a").prepend(careers);
	
	about = '<i class="icon-user"></i>';
	$("#navigation #main-menu > .menu > li:nth-child(7) > a").prepend(about); 
	
	// Homepage Panels  
	
	whatsnew = '<i class="icon-list-ul" style="padding-right:10px;"></i>';
	$('.pane-whats-new h2.pane-title').prepend(whatsnew);
    
  }); // END doc ready
}); // END function
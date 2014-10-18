function imageHandling(){
	$(document).click(function(e){
		try {
/*
			if($("#linAdunitsimage").length && $("#imglinAdunitsimage").length) {
				container2 = $("#linAdunitsimage") ; 
				container1 = $("#imglinAdunitsimage");
				if(e.target.id != "imglinAdunitsimage") {
					container1.removeClass("resize");
					container1.removeClass("ui-resizable");
					try {
						container1.resizable("destroy");
					} catch(err){
						console.log(err.message);
					}
				} else {
					width = $(".nativeAdunits-ul").width();
					height = $(".nativeAdunits-ul").height();
					$("#imglinAdunitsimage").addClass("resize");
					$("#imglinAdunitsimage").resizable({handles: 'ne, se, sw, nw, e, w, n, s' , maxWidth: width ,maxHeight: height});
				}
			}
*/
		} catch(err) {
			console.log(err)
		}
	});
	$(".upload").change(function(e) {
		id = this.id;
		if(id == "fblikeIcon" || id == "fbshareIcon" || id == "gplusIcon" || id == "linkedinIcon" || id == "twitterIcon" || id == "youtubeSnapshot" || id == "videoSnapshot") {
			var _URL = window.URL || window.webkitURL;
			var _validFileExtensions = [".jpg",".gif", ".png", ".jpeg"];
			var ext = $(this).val().split('.').pop().toLowerCase();
			if($.inArray(ext, ['gif','png','jpg']) == -1) {
				  alert("Invalid File, Please upload images with extension 'gif' , 'png' , 'jpg' , 'jpeg' only.");
			} else {
			  var file1, img;
				if ((file1 = this.files[0])) {
					img = new Image();
					img.onload = function(e) {
						var width = this.width;
						var height = this.height;
						var size = file.size
						var widhe = width+"x"+height
						var switchVal = 0;
					};
					img.src = _URL.createObjectURL(file1);
					if(id == "fblikeIcon" ) {
						$("#imgfacebooklikeoranysocialmediawidget").attr('src',img.src);
					} else if(id == "fbshareIcon" ) {
						$("#imgfacebookshare").attr('src',img.src);
					} else if(id == "gplusIcon" ) {
						$("#imggoogleplusshare").attr('src',img.src);
					} else if(id == "linkedinIcon" ) {
						$("#imglinkedinshare").attr('src',img.src);
					} else if(id == "twitterIcon" ) {
						$("#imgtwittershare").attr('src',img.src);
					} else if(id == "youtubeSnapshot" ) {
						$("#imgyoutubesnapshot").attr('src',img.src);
					} else if(id == "videoSnapshot" ) {
						$("#imgvideosnapshot").attr('src',img.src);
					}
				}
			}
		}
	});
	$("#file").change(function(e) {
		var _URL = window.URL || window.webkitURL;
		var _validFileExtensions = [".jpg",".gif", ".png"];
		var ext = $('#file').val().split('.').pop().toLowerCase();
		if($.inArray(ext, ['gif','png','jpg']) == -1) {
				alert("Invalid File, Please upload images with extension 'gif' , 'png' , 'jpg' only.");
		} else {
			var file, img;
			if ((file = this.files[0])) {
				img = new Image();
				img.onload = function(e) {
					var width = this.width;
					var height = this.height;
					var size = file.size
					var widhe = width+"x"+height
					var switchVal = 0;
				};
				img.src = _URL.createObjectURL(file);
				//console.log(img.src);
				$("#linAdunitsimage img").attr('src',img.src);
			}
		}
	});
	$("#file1").change(function(e) {
		var _URL = window.URL || window.webkitURL;
		var _validFileExtensions = [".jpg",".gif", ".png"];
		var ext = $('#file1').val().split('.').pop().toLowerCase();
		if($.inArray(ext, ['gif','png','jpg']) == -1) {
		    alert("Invalid File, Please upload images with extension 'gif' , 'png' , 'jpg' only.");
		} else {
	    var file1, img;
			if ((file1 = this.files[0])) {
				img = new Image();
				img.onload = function(e) {
					var width = this.width;
					var height = this.height;
					var size = file.size
					var widhe = width+"x"+height
					var switchVal = 0;
				};
				img.src = _URL.createObjectURL(file1);
				//console.log(img.src);
			  $("#linAdunitsauthorimage img").attr('src',img.src);
			}
		}
	});
	$("#file2").change(function(e) {
		var _URL = window.URL || window.webkitURL;
		var _validFileExtensions = [".jpg",".gif", ".png"];
		var ext = $('#file2').val().split('.').pop().toLowerCase();
		if($.inArray(ext, ['gif','png','jpg']) == -1) {
		    alert("Invalid File, Please upload images with extension 'gif' , 'png' , 'jpg' only.");
		} else {
	    var file1, img;
			if ((file1 = this.files[0])) {
				img = new Image();
				img.onload = function(e) {
					var width = this.width;
					var height = this.height;
					var size = file.size
					var widhe = width+"x"+height
					var switchVal = 0;
				};
				img.src = _URL.createObjectURL(file1);
				//console.log(img.src);
			  $("#linAdunitscaret img").attr('src',img.src);
			}
		}
	});
}

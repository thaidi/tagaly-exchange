$(function() {
    if($.browser.msie && $.browser.version=="6.0") {
        return(false);
    }
    var titles = new Array();
    titles[0] = "Send Feedback";

    var title = titles[Math.floor(Math.random()*(titles.length))];
    $("#helpthing").text(title);
    $("#helpthing").show();
    $(".help_title span").text(title);
    
    var offset = $("#helpthing").offset();
    var topPadding = 15;

    $(window).scroll(function() {
        if ($(window).scrollTop() > offset.top) {
            $("#helpthing").stop().animate({
                marginTop: $(window).scrollTop() - offset.top + topPadding
            });
        } else {
            $("#helpthing").stop().animate({
                marginTop: 0
            });
        }
    });
});

$('#helpthing').live('click', function() {
    $('#helpthing').hide('slow');
    $('#feedbackform').show('slow');
});

$('#feedbackform #help_cancel').live('click', function() {
    $('#feedbackform').hide('slow');
    $('#helpthing').show('slow');
    $('#feedbackform').html();
});

$('.help_title').live('click', function() {
    $('#feedbackform').hide('slow');
    $('#helpthing').show('slow');
    $('#feedbackform').html();
});

$('#feedbackform #help_submit').live('click', function() {
    var email = $('#help_email').attr('value');
    var feedback = $('#help_feedback').attr('value');
	
	var useragent = $('#help_useragent').attr('value');
	var url = $('#help_url').attr('value');
	var rurl = $('#help_rurl').attr('value');
    
    $.ajax({
        type: "POST",
        url: "/feedback",
        data: "ajax=true&email="+email+"&feedback="+feedback+"&useragent="+useragent+"&url="+url+"&rurl="+rurl,
        success: function(data){
            data = jQuery.parseJSON(data);
            if(data.sent == false) {
                $('#help_errors').html(data.errors);
                $('#feedbackform').animate({ height: $('#help_errors').height()+375 });
                $('#help_errors').show();
            } else {
                $('#feedbackform').children().remove();
                $('#feedbackform').html('<div class="help_thanks_wrap"><p class="help_thanks">Thank You,</p><p class="help_note">Your comments have been submitted to Chitika.</p><p class="help_note"><strong>Note: </strong>All feedback is reviewed by someone on the Chitika team, however - <strong class="red">we generally do not reply to feedback</strong>. If you have an issue and need a reply, please <a href="http://support.chitika.com" target="_blank" >submit a ticket to Chitika Support.</a></p><input type="button" id="help_cancel" name="cancel" value="close" /></div>');
            }
        },
        error:function (xhr, ajaxOptions, thrownError){
            $('#feedbackform').children().remove();
            $('#feedbackform').html('<div class="help_thanks_wrap"><p class="help_thanks">Thank You,</p><p class="help_note">Your comments have been submitted to Chitika.</p><p class="help_note"><strong>Note: </strong>All feedback is reviewed by someone on the Chitika team, however - <strong class="red">we generally do not reply to feedback</strong>. If you have an issue and need a reply, please <a href="http://support.chitika.com" target="_blank" >submit a ticket to Chitika Support.</a></p><input type="button" id="help_cancel" name="cancel" value="close" /></div>');
        }
    });
});
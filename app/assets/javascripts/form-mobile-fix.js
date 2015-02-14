$(document).ready(function() {
    
    /* ======= iOS mobile device bug fix ======== */
    /* Ref: http://stackoverflow.com/questions/7970389/ios-5-fixed-positioning-and-virtual-keyboard */
    
    if (isMobile.any === true) {            
        
        $('input, textarea').on('focus', function(){
            $('.header').css({position:'absolute'});
            $(window).scrollTop(0);
        });
        $('input, textarea').on('blur', function(){
            $('.header').css({position:'fixed'});
        });
    
    }
	
	
});




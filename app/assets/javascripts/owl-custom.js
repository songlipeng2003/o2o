$(document).ready(function() {
   
    /* ======= Owl Carousel ======= */    
    /* Ref: http://owlgraphic.com/owlcarousel/index.html */
    
    $("#home-slideshow").owlCarousel({
                
        autoPlay : 6000,
        singleItem : true,
        autoHeight : true
        
    });


    $("#press-slideshow").owlCarousel({      
        
        autoPlay : 6000,
        items : 3, //3 items above 1000px browser width
        itemsDesktop : [1000,2], //2 items between 1000px and 901px
        itemsDesktopSmall : [900,2], // 2 items betweem 900px and 601px
        itemsTablet: [600,1], //1 item between 600 and 0
        itemsMobile : false // itemsMobile disabled - inherit from itemsTablet option
                
    });
    
    $("#jobs-promo-slideshow").owlCarousel({
        
        navigation : true, // Show next and prev buttons
        navigationText: false,
        singleItem : true,
        slideSpeed : 400,
        autoHeight : true
        
    });

});
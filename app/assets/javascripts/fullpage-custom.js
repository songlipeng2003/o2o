$(document).ready(function() {        
	
	/* ======= Fullpage.js ======= */ 
	/* Ref: https://github.com/alvarotrigo/fullPage.js */
        
    $('#fullpage').fullpage({
		anchors: ['home', 'benefit1', 'benefit2', 'benefit3', 'download'],
		navigation: true,
		navigationPosition: 'right',
		navigationTooltips: ['Home', 'Benefit 1', 'Benefit 2', 'Benefit 3', 'Download'],
		resize : false,
		scrollBar: true,
		autoScrolling: false,
		paddingTop: '120px'
		
	});
    

});
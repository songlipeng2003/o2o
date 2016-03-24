$(document).ready(function() {
  $(window).on('scroll', function() {
    if ($(window).scrollTop() > 0 ) {
      $('#header').addClass('header-change');
    }
    else {
      $('#header').removeClass('header-change');
    }
  });

  $('.weixin').popover({
    html: true,
    content: function(){
      return $('#weixin-qrcode').html();
    }
  });
});

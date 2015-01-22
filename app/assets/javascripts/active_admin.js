//= require active_admin/base

$(function(){
  $('.cascade_select').change(function(){
    var select = $(this);
    var val = select.val();
    var target = $('#'+select.data('cascade-target'));
    if(val!==''){
      target.load('/areas/'+select.val()+'/options');
      target.change();
    }else{
      target.html('<option valued=""></option>');
    }
  });
});

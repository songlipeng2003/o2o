//= require jquery
//= require_self
var isMobile = {
  Android: function() {
    return navigator.userAgent.match(/Android/i);
  },
  BlackBerry: function() {
    return navigator.userAgent.match(/BlackBerry/i);
  },
  iOS: function() {
    return navigator.userAgent.match(/iPhone|iPad|iPod/i);
  },
  Opera: function() {
    return navigator.userAgent.match(/Opera Mini/i);
  },
  Windows: function() {
    return navigator.userAgent.match(/IEMobile/i);
  },
  any: function() {
    return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
  }
};

function isWeiXin(){
  if(navigator.userAgent.toLowerCase().match(/MicroMessenger/i) == 'micromessenger'){
    return true;
  }else{
    return false;
  }
}

$(function(){
  if (isMobile.Android()) {
    if (isWeiXin()) {
      alert('请在右上角点击在浏览器中打开下载');
      // location.href = "http://sj.qq.com/myapp/detail.htm?apkName=com.didi361.didi";
    }else{
      location.href = $('#android').attr('href');
    }
  }else if(isMobile.iOS()) {
    location.href = $('#ios').attr('href');
  }
});

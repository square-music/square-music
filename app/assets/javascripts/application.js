// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
  //= require jquery
  //= require bootstrap-sprockets
  //= require_tree .
  $(function() {

      agreeText();

      $(':checkbox').change(function(){

          agreeText();
      });
  });


  function agreeText() {
      if($('#agree-check').is(':checked')) {
          $('#submit-btn').prop('disabled', false);
      } else {
          $('#submit-btn').prop('disabled', true);
      }
  }

  window.addEventListener('DOMContentLoaded', function() {
  var swiper = new Swiper('.sample01 .swiper-container', {
    pagination: '.swiper-pagination',
    paginationClickable: true,
    slidesPerView: 3,
    spaceBetween: 10,
    centeredSlides : true,
    effect: "slide",
    autoplay: '5000',
    nextButton: '.swiper-button-next',
    prevButton: '.swiper-button-prev',
    loop: true
  });
}, false);
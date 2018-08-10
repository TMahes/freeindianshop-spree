// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require accounting.min
//= require spree/frontend

//= require_tree .
//= require spree/frontend/spree_auth
//= require spree/frontend/spree_drop_ship
//= require spree/frontend/slick.min

$(document).on('ready', function() {

  // Home Page Slider
  $(".regular").slick({
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1
  });

  // All Responsive Tables
  $( ".table" ).wrap( "<div class='table-responsive'></div>" );

  // For Header Responsive
  $(".search_toggle").click(function(){
    $(".search_area").toggleClass("search_open");
    $("body").toggleClass("modal-open");
    $(".responsive-overlay").toggleClass("open");
  });

  $(".userbar_toggle").click(function(){
    $("#top-nav-bar").toggleClass("userbar_open");
    $("body").toggleClass("modal-open");
    $(".responsive-overlay").toggleClass("open");
  });

  $(".sidebar_toggle").click(function(){
    $("#sidebar").toggleClass("sidebar_open");
    $("body").toggleClass("modal-open");
    $(".responsive-overlay").toggleClass("open");
  });

});
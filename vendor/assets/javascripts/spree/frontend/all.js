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
$(document).ready(function(){
	$('.categories-menu').each(function(){
	  var filterAmount = $(this).find('li').length;
	  console.log(filterAmount);
	  if( filterAmount > 8){    
	    $('li', this).eq(8).nextAll().hide().addClass('toggleable');
	    $(this).append('<li class="more">More</li>');    
	  }  
	});

	$('.categories-menu').on('click','.more', function(){
	  if( $(this).hasClass('less') ){    
	    $(this).text('More').removeClass('less');    
	  }else{
	    $(this).text('Less').addClass('less'); 
	  }
	  $(this).siblings('li.toggleable').slideToggle(); 
	});

	$(document).on('click','#category-clear-all',function(){
	  $('.category-clear-selection').prop('checked', false);
	}); 

	$(document).on('click','#size-clear-all',function(){
	  $('.category-clear-selection-two').prop('checked', false);
	});

	$(document).on('click','#color-clear-all',function(){
	  $('.clear-color').prop('checked', false);
	});
	$(document).on('click','#price-clear-all',function(){
	  $('.clear-price').prop('checked', false);
	});    

});


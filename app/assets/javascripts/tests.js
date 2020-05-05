$(document).on('turbolinks:load', ()=> { 
  $(".header__contents__nav--left--category").hover(function() {
  $("ul.category1").toggle();
  });
  $(".header__contents__nav--left--category li ul").hide();
  $(".header__contents__nav--left--category li").hover(function() {
	$(">ul:not(:animated)", this).stop(true, true).slideDown("fast");
	$("child.name", this).addClass("active");
  }, function() {
	$(">ul:not(:animated)", this).stop(true, true).slideUp("fast");
	$("grandchild.name", this).removeClass("active");
  });
});
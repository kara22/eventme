$(document).ready(function(){
    $('.attendee:nth-child(1)').css("display", "block");

      $(".attendee").on("swiperight",function(){

      $(this).addClass('rotate-left').delay(700).fadeOut(1);
      // $('.buddy').find('.status').remove();

      $(this).append('<div class="status like">Like!</div>');
      if ( $(this).is(':last-child') ) {
        $('.attendee:nth-child(1)').removeClass('rotate-left rotate-right').fadeIn(300);
      } else {
        $(this).next().removeClass('rotate-left rotate-right').fadeIn(400);
      }
      if ( $(this).is(':last-child') ) {
       //$('.attendee:nth-child(1)').removeClass ('rotate-left rotate-right').fadeIn(300);
        setTimeout(function() {
          console.log('Vous avez liké tous les profils de cet event');
          $('.attendee').hide();
        }, 1000);
      return;

     } else {
        $(this).next().removeClass('rotate-left rotate-right').fadeIn(400);
     }
      $(this).find('.swipe-like form').submit();
    });

   $(".attendee").on("swipeleft",function(){
    $(this).addClass('rotate-right').delay(700).fadeOut(1);
    // $('.buddy').find('.status').remove();
    $(this).append('<div class="status dislike">Dislike!</div>');

    if ( $(this).is(':last-child') ) {
     //$('.attendee:nth-child(1)').removeClass ('rotate-left rotate-right').fadeIn(300);
        setTimeout(function() {
          console.log('Vous avez liké tous les profils de cet event');
          $('.attendee').hide();
        }, 1000);
      return;
     } else {
        $(this).next().removeClass('rotate-left rotate-right').fadeIn(400);
    }
    $(this).find('.swipe-dislike form').submit();
  });





});

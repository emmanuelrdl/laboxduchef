
$(document).ready(function() {
  $('#myCarousel').carousel({
  interval: 4000
  })

    $('#myCarousel').on('slid.bs.carousel', function() {
      //alert("slid");
  });


});

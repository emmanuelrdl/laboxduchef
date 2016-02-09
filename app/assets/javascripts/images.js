
$(document).ready(function () {
    $('.btn-waiting').click(function() {
    $('#modal_waiting').modal('show');
      });
});

$(window).load(function(){
  $('#modal_waiting').modal('hide');
});

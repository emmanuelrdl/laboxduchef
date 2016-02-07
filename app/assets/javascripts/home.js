$(document).on('page:fetch', function() {
  $("#spinner").show();
});
$(document).on('page:change', function() {
  $("#spinner").hide();
});

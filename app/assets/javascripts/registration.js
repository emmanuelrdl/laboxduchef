$(document).ready(function() {
  $('#address-box').hide();
  $(":checkbox").click(function(event) {
    if ($(this).is(":checked"))
      $("#address-box").show();
    else
      $("#address-box").hide();
  });
});

$("#address-box").hide();
$("#user_notification").click(function() {
    if($(this).is(":checked")) {
        $("#address-box").show(300);
    } else {
        $("#address-box").hide(200);
    }
});

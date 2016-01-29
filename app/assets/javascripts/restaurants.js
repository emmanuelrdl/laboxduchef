$("#open_noon_true").hide();
$("#open_noon").click(function() {
    if($(this).is(":checked")) {
        $("#open_noon_true").show(300);
    } else {
        $("#open_noon_true").hide(200);
    }
});

$("#open_evening_true").hide();
$("#open_evening").click(function() {
    if($(this).is(":checked")) {
        $("#open_evening_true").show(300);
    } else {
        $("#open_evening_true").hide(200);
    }
});

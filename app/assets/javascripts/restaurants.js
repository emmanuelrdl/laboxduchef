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


$("#closing_day_one").hide();
$("#closing_day_one_btn").click(function() {
        $("#closing_day_one").toggle(300);
});



$("#closing_day_two").hide();
$("#closing_day_two_btn").click(function() {
        $("#closing_day_two").toggle(300);
});

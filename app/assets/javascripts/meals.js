//plugin bootstrap minus and plus
//http://jsfiddle.net/laelitenetwork/puJ6G/

 // start btn meal show quantity
$('.btn-number').click(function(e){
    e.preventDefault();

    fieldName = $(this).attr('data-field');
    type      = $(this).attr('data-type');
    var input = $("input[name='"+fieldName+"']");
    var currentVal = parseInt(input.val());
    if (!isNaN(currentVal)) {
        if(type == 'minus') {

            if(currentVal > input.attr('min')) {
                input.val(currentVal - 1).change();
            }
            if(parseInt(input.val()) == input.attr('min')) {
                $(this).attr('disabled', true);
            }

        } else if(type == 'plus') {

            if(currentVal < input.attr('max')) {
                input.val(currentVal + 1).change();
            }
            if(parseInt(input.val()) == input.attr('max')) {
                $(this).attr('disabled', true);
            }

        }
    } else {
        input.val(0);
    }
});


// $("#").hide();
// $("#take-away-noon-box").click(function() {
//     if($(this).is(":checked")) {
//         $("#take-away-noon-content").show(300);
//     } else {
//         $("#take-away-noon-content").hide(200);
//     }
// });






// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

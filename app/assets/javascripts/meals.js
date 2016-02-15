//plugin bootstrap minus and plus
//http://jsfiddle.net/laelitenetwork/puJ6G/


// price calculation meal
$('.btn-number').click(function(e){
    e.preventDefault();

    fieldName = $(this).attr('data-field');
    type      = $(this).attr('data-type');
    var input = $("input[name='"+fieldName+"']");
    var currentVal = parseInt(input.val());
    if (!isNaN(currentVal)) {
        if(type == 'minus') {

            if(currentVal > input.attr('min')) {
                input.val(currentVal - 0).change();

            }
            if(parseInt(input.val()) == input.attr('min')) {
                $(this).attr('disabled', true);


            }

        } else if(type == 'plus') {

            if(currentVal < input.attr('max')) {
                input.val(currentVal + 0).change();
            }
            if(parseInt(input.val()) == (input.attr('max') -1)) {
                $(this).attr('disabled', true);
            }

        }
    } else {
        input.val(0);
    }
});


$(document).ready(function()
{
    var basePrice = parseFloat($(".price").text());


          $(".minus").click(function()
          {
              changeValue(-1);
               $(".plus").attr('disabled', false)
          });



          $(".plus").click(function()
          {
              changeValue(1);
              $(".minus").attr('disabled', false)
          });



    function changeValue(sign)
    {
        $("[name='order[quantity]']").val(parseInt($("[name='order[quantity]']").val()) + sign);
        var countValue = $("[name='order[quantity]']").val();
        var newValue = (basePrice * countValue).toFixed(2);
        $(".price").text(newValue);
    }
});


// price calculation meal



// meal new

jQuery(document).ready(function(){
    // This button will increment the value
    $('.qtyplus').click(function(e){
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        fieldName = $(this).attr('field');
        // Get its current value
        var currentVal = parseInt($('#'+fieldName).val());
        // If is not undefined
        if (!isNaN(currentVal)) {
            // Increment
            $('#'+fieldName).val(currentVal + 1);
        } else {
            // Otherwise put a 0 there
           $('#'+fieldName).val(0);
        }
    });
    // This button will decrement the value till 0
    $(".qtyminus").click(function(e) {
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        fieldName = $(this).attr('field');
        // Get its current value
        var currentVal = parseInt($('#'+fieldName).val());
        // If it isn't undefined or its greater than 0
        if (!isNaN(currentVal) && currentVal > 0) {
            // Decrement one
            $('#'+fieldName).val(currentVal - 1);
        } else {
            // Otherwise put a 0 there
            $('#'+fieldName).val(0);
        }
    });
});


// meal new search


$("#index_address_input").hide();
$("#change_place").click(function(){
    $("#index_address_input").toggle();
    $("#change_place_block").hide();
     return false;

});

// meal new search

// meal xs new search

$("#index_address_input_xs").hide();
$("#change_place_xs").click(function(){
    $("#index_address_input_xs").toggle();
     return false;

});

// meal xs new search





// hide meal search bar xs


$("#navbar-btn").click(function(){
    $("#meal_search_header_xs").toggle();

});


//hide meal search bar xs


// uncheck take away days
$('#permanent').on('change', function() {
    $('#starting_date').not(this).prop('checked', false);
    $('#second_date').not(this).prop('checked', false);
});

$('#starting_date').on('change', function() {
    $('#permanent').not(this).prop('checked', false);
});

$('#second_date').on('change', function() {
    $('#permanent').not(this).prop('checked', false);
});


// uncheck take away days



// loading modal

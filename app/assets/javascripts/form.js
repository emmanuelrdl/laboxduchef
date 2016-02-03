// check the value of meal and restaurant picture

//  document.getElementById("meal_picture").onchange = function () {
//  document.getElementById("uploadFile").value = this.value;
// };


// document.getElementById("upload").onchange = function () {

// };

// check the value of meal and restaurant picture

$(document).on('change', '#upload', function() {
document.getElementById("uploadFile").value = this.value;
});

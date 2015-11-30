$(document).ready(function(){
    setInterval(function(){
        getLocation(function(position) {
            //do something cool with position
            currentLat = position.coords.latitude;
            currentLng = position.coords.longitude;

            $("#status").html(currentLat + " " + currentLng);
        });
    }, 1000);
});


var GPSTimeout = 10; //init global var NOTE: I noticed that 10 gives me the quickest result but play around with this number to your own liking


//function to be called where you want the location with the callback(position)
function getLocation(callback)
{
    if(navigator.geolocation)
    {
        var clickedTime = (new Date()).getTime(); //get the current time
        GPSTimeout = 10; //reset the timeout just in case you call it more then once
        ensurePosition(callback, clickedTime); //call recursive function to get position

    }
    return true;
}


    // GeoLocation
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position){
            var latitude = position.coords.latitude;
            var longitude = position.coords.longitude;
            //console.log('latitude: '+latitude+' longitude: '+longitude);
            geocodeLatLng(latitude, longitude);
        }, function(error){
            console.log(error);
        });
    } else {
        console.log('Geolocation is not enabled.');
    }

    // Start - Reverse Geocoding
    function geocodeLatLng(latitude, longitude) {
        var geocoder = new google.maps.Geocoder;
        var latlng = {lat: parseFloat(latitude), lng: parseFloat(longitude)};
        //var latlng = {lat: 40.731, lng: -73.997};
        geocoder.geocode({'location': latlng}, function(results, status) {
            if (status === google.maps.GeocoderStatus.OK) {
                if(results[0]) {
                    //console.log(results[0].address_components);
                    var address = results[0].address_components;
                    var location = '';
                    var locality;
                    for(var i=0; i<address.length; i++)
                        if(address[i].types[0]=='sublocality_level_1')
                            location += address[i].long_name + ', ';
                        else if(address[i].types[0]=='locality') {
                            location += address[i].long_name + ', ';
                            locality = address[i].long_name;
                        }
                        else if(address[i].types[0]=='administrative_area_level_1' && address[i].short_name!=locality)
                            location += address[i].long_name + ', ';
                        else if(address[i].types[0]=='country') {
                            location += address[i].long_name;
                            $scope.country_code = address[i].short_name;
                        }
                    $scope.location = location;
                    console.log($scope.location);
                    console.log($scope.country_code);
                }
                else
                    console.log('No results found');
            } else {
                console.log('Geocoder failed due to: ' + status);
            }
        });
    }
    // End - Reverse Geocoding

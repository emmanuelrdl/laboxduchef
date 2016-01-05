function initializeAutocomplete(id) {
  var element = document.getElementById(id);
  if (element) {
    var autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
  }
}


function onPlaceChanged() {
  var place = this.getPlace();

  // console.log(place);  // Uncomment this line to view the full object returned by Google API.

  var street = '';

  for (var i in place.address_components) {
    var component = place.address_components[i];

    for (var j in component.types) {  // Some types are ["country", "political"]
      var type_name = component.types[j];
      var type_element = document.getElementById(component.types[j]);

      if (type_name == 'street_number' || type_name == 'route') {
        street = street + ' ' + component.long_name;
      }

      if (type_element) {
        type_element.value = component.long_name;
      }
    }

  }

  document.getElementById('street').value = street;
}


google.maps.event.addDomListener(window, 'load', function() {
  initializeAutocomplete('user_input_autocomplete_address');
});

function initializeAutocomplete(id) {
  var element = document.getElementById(id);
  if (element) {
    var autocomplete = new google.maps.places.Autocomplete(element, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
  }
}


function onPlaceChanged() {
  var place = this.getPlace();

  // console.log(place);  // Uncomment this line to view the full object returned by Google API.

  var street = '';

  for (var i in place.address_components) {
    var component = place.address_components[i];

    for (var j in component.types) {  // Some types are ["country", "political"]
      var type_name = component.types[j];
      var type_element = document.getElementById(component.types[j]);

      if (type_name == 'street_number' || type_name == 'route') {
        street = street + ' ' + component.long_name;
      }

      if (type_element) {
        type_element.value = component.long_name;
      }
    }

  }

  document.getElementById('street').value = street;
}


google.maps.event.addDomListener(window, 'load', function() {
  initializeAutocomplete('user_input_autocomplete_address_xs');
});

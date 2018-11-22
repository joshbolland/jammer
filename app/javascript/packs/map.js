import 'mapbox-gl/dist/mapbox-gl.css'
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css'
import mapboxgl from 'mapbox-gl/dist/mapbox-gl.js';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const mapElement = document.getElementById('map');

if (mapElement) { // only build a map if there's a div#map to inject into
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  const map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/renatasva/cjosydc3g0iav2rs8jdeearyi'
  });

  map.addControl(new MapboxGeocoder({
    accessToken: mapboxgl.accessToken
  }));

  const markers = JSON.parse(mapElement.dataset.markers);

  markers.forEach((marker) => {
    new mapboxgl.Marker()
      .setLngLat([marker.lng, marker.lat])
      .setPopup(new mapboxgl.Popup({ offset: 25 }) // add popups
      .setHTML(marker.infoWindow.content))
      .addTo(map);
  })

  if (markers.length === 0) {
    map.setZoom(1);
  } else if (markers.length === 1) {
    map.setZoom(13);
    map.setCenter([markers[0].lng, markers[0].lat]);
  } else {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach((marker) => {
      bounds.extend([marker.lng, marker.lat]);
    });
    map.fitBounds(bounds, { duration: 1000, padding: 75 })
  }
}

const locationInput = document.getElementById('jam_location');

if (locationInput) {
  const places = require('places.js');
  const placesAutocomplete = places({
    container: locationInput
  });
}

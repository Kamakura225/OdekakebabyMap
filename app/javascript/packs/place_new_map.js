let map;
let marker;

function initMap() {
  const latitudeElement = document.getElementById('place_latitude');
  const longitudeElement = document.getElementById('place_longitude');
  const addressElement = document.getElementById('place_address');
  const mapElement = document.getElementById("map");

  if (!latitudeElement || !longitudeElement || !mapElement) return;

  const defaultLocation = { lat: 35.681236, lng: 139.767125 };
  const latitude = latitudeElement.value;
  const longitude = longitudeElement.value;

  const markerPosition = latitude && longitude 
    ? { lat: parseFloat(latitude), lng: parseFloat(longitude) } 
    : defaultLocation;

  map = new google.maps.Map(mapElement, {
    center: markerPosition,
    zoom: 13,
  });

  marker = new google.maps.Marker({
    position: markerPosition,
    map: map,
    draggable: true
  });

  marker.addListener('dragend', () => {
    const position = marker.getPosition();
    latitudeElement.value = position.lat();
    longitudeElement.value = position.lng();
    reverseGeocode(position, addressElement);
  });

  map.addListener('click', event => {
    const position = event.latLng;
    marker.setPosition(position);
    latitudeElement.value = position.lat();
    longitudeElement.value = position.lng();
    reverseGeocode(position, addressElement);
  });

  document.querySelector('form')?.addEventListener('submit', function(event) {
    if (addressElement && !addressElement.value) {
      event.preventDefault();
      alert('住所がまだ取得できていません。もう少し待ってから再度送信してください。');
    }
  });
}

// 逆ジオコーディング
function reverseGeocode(latLng, addressElement) {
  const geocoder = new google.maps.Geocoder();
  geocoder.geocode({ location: latLng }, (results, status) => {
    if (status === "OK" && results[0]) {
      addressElement.value = results[0].formatted_address;
    } else {
      console.error("住所が見つかりませんでした: " + status);
    }
  });
}

window.initMap = initMap;
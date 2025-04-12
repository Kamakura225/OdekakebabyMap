let map;
let marker;

function initMap() {
  const defaultLocation = { lat: 35.681236, lng: 139.767125 };

  const map = new google.maps.Map(document.getElementById("map"), {
    center: defaultLocation,
    zoom: 13,
  });

  // 既にフォームに設定されている緯度・経度があれば、それをマーカーの位置として設定
  const latitude = document.getElementById('place_latitude').value;
  const longitude = document.getElementById('place_longitude').value;

  const markerPosition = latitude && longitude ? { lat: parseFloat(latitude), lng: parseFloat(longitude) } : defaultLocation;

  const geocoder = new google.maps.Geocoder();
  
  marker = new google.maps.Marker({
    position: markerPosition,
    map: map,
    draggable: true
  });

  // マーカーが動いたときに、緯度・経度をフォームにセット
  google.maps.event.addListener(marker, 'dragend', function() {
    const position = marker.getPosition();
    document.getElementById('place_latitude').value = position.lat();
    document.getElementById('place_longitude').value = position.lng();
    reverseGeocode(geocoder, position);
  });

  // 地図をクリックした時にもマーカーを置いて、その位置の緯度・経度をフォームにセット
  google.maps.event.addListener(map, 'click', function(event) {
    const position = event.latLng;
    marker.setPosition(position);
    document.getElementById('place_latitude').value = position.lat();
    document.getElementById('place_longitude').value = position.lng();
    reverseGeocode(geocoder, position);
  });
  
  // 地図にマーカー置いたらその一の住所をフォームにセット
  function reverseGeocode(geocoder, latLng) {
    geocoder.geocode({ location: latLng }, (results, status) => {
      if (status === "OK" && results[0]) {
        document.getElementById("place_address").value = results[0].formatted_address;
      } else {
        console.error("住所が見つかりませんでした: " + status);
      }
    });
  }
}

// Google Maps API の callback 関数として使えるようにする
window.initMap = initMap;

document.addEventListener('DOMContentLoaded', () => {
  const form = document.querySelector('form');
  if (!form) return;

  form.addEventListener('submit', function(event) {
    const addressField = document.getElementById('place_address');
    if (!addressField.value) {
      event.preventDefault();
      alert('住所がまだ取得できていません。もう少し待ってから再度送信してください。');
    }
  });
});
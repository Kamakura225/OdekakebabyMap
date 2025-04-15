// indexページで動くマップだけのJS
window.initMap = function() {
  const map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 35.681236, lng: 139.767125 },
    zoom: 12,
  });

  // 施設一覧（@places）をマップにマーカー表示
  renderMarkers(map, places);
};

// 施設一覧を描画する関数
function renderMarkers(map, places) {
  places.forEach(place => {
    const marker = new google.maps.Marker({
      position: { lat: place.latitude, lng: place.longitude },
      map: map,
      title: place.name
    });

    // マーカーをクリックしたときに詳細表示
    marker.addListener("click", () => {
      document.getElementById("place-photo").src = place.main_image_url || '/no_image.jpg';
      document.getElementById("place-name").textContent = place.name;
      document.getElementById("place-details").textContent = place.facility_summary;
      document.getElementById("place-link").href = place.place_path;
      document.getElementById("place-info-banner").style.display = "block";
    });
  });
}
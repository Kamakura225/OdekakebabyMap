console.log("place_index_map.js loaded!");

window.initMap = function () {
  
  const map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 35.681236, lng: 139.767125 },
    zoom: 15,
  });

  renderMarkers(map, window.places); 
  setupFilter(map);
};

let markers = [];

function renderMarkers(map, places) {
  markers.forEach(marker => marker.setMap(null));
  markers = [];

  places.forEach(place => {
    const marker = new google.maps.Marker({
      position: { lat: place.latitude, lng: place.longitude },
      map: map,
      title: place.name,
    });

    marker.addListener("click", () => {
      document.getElementById("place-photo").src = place.main_image_url || "/no_image.jpg";
      document.getElementById("place-name").textContent = place.name;
      document.getElementById("place-details").textContent = place.facility_summary;
      document.getElementById("place-link").href = place.place_path;
      document.getElementById("place-info-banner").style.display = "block";
    });

    markers.push(marker);
  });
}

function setupFilter(map) {
  const $ = window.jQuery;

  $("#filter-form input").on("change", function () {
    applyFilters(map);
  });

  $("#search-btn").on("click", function () {
    applyFilters(map);
  });
  
}

function applyFilters(map) {
  const filterNursery = $("#filter_nursery").prop("checked");
  const filterPark = $("#filter_category_park").prop("checked");
  const keyword = $("#keyword-search").val().toLowerCase().trim();
  const keywords = keyword.split(/\s+/); // スペースで分割（AND検索）

  const filtered = window.places.filter(place => {
    // チェックボックスフィルター
    if (filterNursery && !place.nursery) return false;
    if (filterPark && place.category !== "park") return false;
    return keywords.every(kw =>
      place.name.toLowerCase().includes(kw) ||
      place.facility_summary?.toLowerCase().includes(kw)
    );
  });

  if (filtered.length > 0) {
    renderMarkers(map, filtered);

    // 最初の一致施設を中心に移動
    const first = filtered[0];
    map.setCenter({ lat: first.latitude, lng: first.longitude });
    map.setZoom(16); // 少し拡大
  } else {
    alert("一致する施設が見つかりませんでした");
  }

  // 情報バナーは一旦閉じる
  document.getElementById("place-info-banner").style.display = "none";
}


window.initMap = function () {
  
  const map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 35.681236, lng: 139.767125 },
    zoom: 15,
  });

  renderMarkers(map, window.places); 
  setupFilter(map);
};

let markers = [];



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
  const filterFacility = $("#filter_category_facility").prop("checked");
  const filterPark = $("#filter_category_park").prop("checked");
  const filterNursery = $("#filter_nursery").prop("checked");
  const filterDiaper = $("#filter_diaper").prop("checked");
  const filterKidsToilet = $("#filter_kidstoilet").prop("checked");
  const filterStroller = $("#filter_stroller").prop("checked");
  const filterPlayground = $("#filter_playground").prop("checked");
  const filterShade = $("#filter_shade").prop("checked");
  const filterBench = $("#filter_bench").prop("checked");
  const filterElevator = $("#filter_elevator").prop("checked");
  const filterParking = $("#filter_parking").prop("checked");
  const keyword = $("#keyword-search").val().toLowerCase().trim();
  const keywords = keyword.split(/\s+/); // スペースで分割（AND検索）

  const noFilterActive =
    !filterFacility &&
    !filterPark &&
    !filterNursery &&
    !filterDiaper &&
    !filterKidsToilet &&
    !filterStroller &&
    !filterPlayground &&
    !filterShade &&
    !filterBench &&
    !filterElevator &&
    !filterParking &&
    keyword === "";

  if (noFilterActive) {
    renderMarkers(map, window.places); // 全部のマーカー表示
    map.setCenter({ lat: 35.681236, lng: 139.767125 }); // 初期地点
    map.setZoom(15); // 初期ズーム
    document.getElementById("place-info-banner").style.display = "none";
    return; // 終了
  }

  const filteredPlaces = window.places.filter(place => {
    // チェックボックスフィルター
    if (filterFacility && place.category !== "facility") return false;
    if (filterPark && place.category !== "park") return false;
    if (filterNursery && !place.nursery) return false;
    if (filterDiaper && !place.diaper) return false;
    if (filterKidsToilet && !place.kids_toilet) return false;
    if (filterStroller && !place.stroller) return false;
    if (filterPlayground && !place.playground) return false;
    if (filterShade && !place.shade) return false;
    if (filterBench && !place.bench) return false;
    if (filterElevator && !place.elevator) return false;
    if (filterParking && !place.parking) return false;
    return keywords.every(kw =>
      place.name.toLowerCase().includes(kw) ||
      place.facility_summary?.toLowerCase().includes(kw)
    );
  });
 // フィルター結果を地図上に表示
  renderMarkers(map, filteredPlaces);

  if (filteredPlaces.length > 0) {
    const first = filteredPlaces[0];
    map.setCenter({ lat: first.latitude, lng: first.longitude });
   map.setZoom(16); // 少し拡大
  } else {
   // マーカーは消しても地図は初期状態に戻す
   map.setCenter({ lat: 35.681236, lng: 139.767125 }); // 東京駅など
   map.setZoom(15); // 初期ズーム
    alert("一致する施設が見つかりませんでした");
  }

// 情報バナーは一旦閉じる
document.getElementById("place-info-banner").style.display = "none";
}

function renderMarkers(map, places) {
markers.forEach(marker => marker.setMap(null)); // 既存のマーカーをクリア
markers = []; // markers配列をリセット

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

  markers.push(marker); // 新しいマーカーを配列に追加
});
}
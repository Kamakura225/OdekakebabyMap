// ブートストラップ ローダ
(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.GOOGLE_MAPS_API_KEY

});

let map;
let marker;
let geocoder;

async function initMap() {
  try {
  
    // 必要なライブラリをインポート
    const { Map } = await google.maps.importLibrary("maps");
    const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

    // ジオコーダーの初期化
    geocoder = new google.maps.Geocoder();

    // 地図の初期化
    map = new Map(document.getElementById("map"), {
      center: { lat: 35.6803997, lng: 139.7690174 },
      zoom: 15,
      mapTypeControl: false,
    });

    // 住所検索ボタンのイベントリスナー
    const searchButton = document.getElementById("search-address-btn");
  searchButton.addEventListener("click", codeAddress);
  searchButton.disabled = false;

  
  } catch (error) {
    console.error("Error initializing map:", error);
    alert("地図の読み込みに失敗しました。ページをリロードしてください。");
  }
}

async function codeAddress() {
  const addressInput = document.getElementById("address").value;
  
  try {
    const results = await new Promise((resolve, reject) => {
      geocoder.geocode({ address: addressInput }, (results, status) => {
        if (status === "OK") {
          resolve(results);
        } else {
          reject(new Error(`Geocode failed: ${status}`));
        }
      });
    });

    // 既存のマーカーを削除
    if (marker) {
      marker.setMap(null);
    }

    const position = results[0].geometry.location;
    map.setCenter(position);

    // 新しいマーカーを作成
    marker = new google.maps.Marker({
      map: map,
      position: position,
      draggable: true,
    });

    // フォームに緯度・経度・住所を設定
    document.getElementById("lat").value = position.lat();
    document.getElementById("lng").value = position.lng();
    document.getElementById("place_address").value = results[0].formatted_address;

    // ドラッグ終了時のイベントリスナー
    marker.addListener("dragend", (ev) => {
      const newPosition = ev.latLng;
      document.getElementById("lat").value = newPosition.lat();
      document.getElementById("lng").value = newPosition.lng();
      reverseGeocode(newPosition);
    });
  } catch (error) {
    console.error("Error in codeAddress:", error);
    alert("該当する場所が見つかりませんでした：" + error.message);
  }
}

async function reverseGeocode(latlng) {
  try {
    const results = await new Promise((resolve, reject) => {
      geocoder.geocode({ location: latlng }, (results, status) => {
        if (status === "OK") {
          resolve(results);
        } else {
          reject(new Error(`Reverse geocode failed: ${status}`));
        }
      });
    });

    document.getElementById("place_address").value = results[0].formatted_address;
  } catch (error) {
    console.error("Error in reverseGeocode:", error);
    alert("住所の取得に失敗しました。");
  }
}

initMap();
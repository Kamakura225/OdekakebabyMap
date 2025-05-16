(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.GOOGLE_MAPS_API_KEY

});

let map;
let markers = [];
let geocoder;

// 地図の初期化
async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

  geocoder = new google.maps.Geocoder();

  map = new Map(document.getElementById("map"), {
    center: { lat: 35.681236, lng: 139.767125 },
    zoom: 15,
    mapId: "DEMO_MAP_ID",
    mapTypeControl: false,
  });

  const searchButton = document.getElementById("search-address-btn");
  searchButton.addEventListener("click", codeAddress);
  searchButton.disabled = false;

  const filterForm = document.querySelector("form");
    const filterSubmitButton = filterForm.querySelector('input[type="submit"]');
    filterSubmitButton.disabled = false; // 初期化時に有効化
    filterForm.addEventListener("submit", async (event) => {
      event.preventDefault();
      filterSubmitButton.disabled = true; // 処理中は無効化
      await updateMarkers();
      filterSubmitButton.disabled = false; // 処理完了後に有効化
  });
  
  await updateMarkers();
}

function clearMarkers() {
  markers.forEach((marker) => {
    marker.map = null; 
  });
  markers = []; 
}

async function updateMarkers() {
  clearMarkers(); 

  try {    
    const form = document.querySelector("form");
    const formData = new FormData(form);
    const queryParams = new URLSearchParams(formData).toString();
    const response = await fetch(`/public/places.json?${queryParams}`);

    if (!response.ok) throw new Error("Network response was not ok");

    const jsonData = await response.json();
    const items = jsonData.data.items;

    if (!Array.isArray(items)) {
      throw new Error("Items is not an array");
    }
    
    items.forEach((item) => {
      const latitude = item.latitude;
      const longitude = item.longitude;
      const name = item.name;
      const category = item.category;
      const id = item.id;

      const marker = new google.maps.marker.AdvancedMarkerElement({
        position: { lat: latitude, lng: longitude },
        map,
        title: name,
      });

      marker.place = {
        name: name,
        category: category,
        latitude: latitude,
        longitude: longitude,
      };

      const contentString = `
        <div class="information container p-0">
          <div>
            <h3 class="h4 font-weight-bold">
              <a href="/public/places/${id}" class="text-decoration-none">${name}</a>            
            </h3>
            <p class="text-muted">${item.address}</p>
          </div>
        </div>
      `;

      const infowindow = new google.maps.InfoWindow({
        content: contentString,
        ariaLabel: name,
      });

      marker.addListener("click", () => {
        infowindow.open({
          anchor: marker,
          map,
        });
      });

      markers.push(marker);
    });
  } catch (error) {
    console.error("Error fetching or processing place data:", error);
  }
}

function codeAddress() {
  const addressInput = document.getElementById("address").value;

  geocoder.geocode({ address: addressInput }, function (results, status) {
    if (status === "OK") {
      const position = results[0].geometry.location;
      map.setCenter(position);
    } else {
      alert("該当する場所が見つかりませんでした：" + status);
    }
  });
}

initMap();


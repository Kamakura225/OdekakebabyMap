json.data do
  json.items do
    json.array!(@places) do |place|
      json.id place.id
      json.name place.name
      json.address place.address
      json.latitude place.latitude
      json.longitude place.longitude
      json.category place.category
      json.nursery place.nursery
      json.diaper place.diaper
      json.kids_toilet place.kids_toilet
      json.stroller place.stroller
      json.playground place.playground
      json.shade place.shade
      json.bench place.bench
      json.elevator place.elevator
      json.parking place.parking
      json.status I18n.t("place.status.#{place.status}") 
      
    end
  end
end
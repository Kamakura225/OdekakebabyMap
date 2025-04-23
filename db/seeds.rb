# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(email: ENV['Admin_Email']) do |admin|
    admin.password = ENV['Admin_Password']
    admin.password_confirmation = ENV['Admin_Password']
end

# サンプルユーザー作成
user = User.find_or_create_by!(email: "user1@example.com") do |u|
    u.password = "password1"
    u.password_confirmation = "password1"
    u.nickname = "とら"
    u.is_active = true
end

# 施設データ作成
25.times do |n|
    latitude = Faker::Address.latitude.to_f
    longitude = Faker::Address.longitude.to_f
    Place.create!(
        name: "Example Place #{n + 1}",
        address: Faker::Address.full_address,
        category: [0, 1].sample, # 例: 0が施設, 1が公園
        latitude: latitude,
        longitude: longitude,
        nursery: [true, false].sample,
        diaper: [true, false].sample,
        kids_toilet: [true, false].sample,
        stroller: [true, false].sample,
        playground: [true, false].sample,
        shade: [true, false].sample,
        bench: [true, false].sample,
        elevator: [true, false].sample,
        parking: [true, false].sample,
        status: 1, # 例: 公開/非公開/保留 などに対応
        user: user
    )
end

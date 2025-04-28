# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.find_or_create_by(email: ENV['Admin_Email']) do |admin|
    admin.password = ENV['Admin_Password']
    admin.password_confirmation = ENV['Admin_Password']
end

# サンプルユーザー作成
User.find_or_create_by(email: "user1@example.com") do |u|
    u.password = "password1"
    u.password_confirmation = "password1"
    u.nickname = "とら"
    u.is_active = true
end

10.times do |i|
    Place.create!(
      name: "テスト施設#{i + 1}",
      address: "東京都千代田区丸の内#{i + 1}-1-1",
      category: i.even? ? 0 : 1, 
      latitude: 35.681236 + rand(-0.11..0.21),
      longitude: 139.767125 + rand(-0.21..0.11),
      user_id: 1,
      nursery: [true, false].sample,
      diaper: [true, false].sample,
      kids_toilet: [true, false].sample,
      stroller: [true, false].sample,
      playground: [true, false].sample,
      shade: [true, false].sample,
      bench: [true, false].sample,
      elevator: [true, false].sample,
      parking: [true, false].sample,
      status: 1  
    )
  end  
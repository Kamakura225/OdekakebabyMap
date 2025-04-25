# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.find_or_create_by!(email: ENV['Admin_Email']) do |admin|
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



tag_names = [
    "授乳室", "おむつ交換台", "幼児トイレ", "ベビーカー対応", "遊具",
    "木陰", "ベンチ", "エレベータ", "駐車場"
]

tag_names.each do |name| 
    Tag.find_or_create_by!(name: name)
end

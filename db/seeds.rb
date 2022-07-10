# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tags = %w( エンジニア 学習 転職活動 Ruby)
tags.each {|tag|Tag.find_or_create_by!(name:tag)}

3.times do |n|
  user = User.find_or_create_by!(email: "user00#{n+1}@test.com")do|_user|
  _user.password = "test1234"
  end

  50.times do |i|
    user.articles.find_or_create_by!(title:"No.#{i+1}:user00#{n+1}の記事")do|article|
    article.content = "No.#{i+1}:user00#{n+1}の記事の本文"
    article.tag_ids =Tag.all.pluck(:id)
    end
  end
end

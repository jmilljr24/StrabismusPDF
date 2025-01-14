# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 40.times do
#   BlogPost.create do |post|
#     post.content = ActionText::RichText.first.body
#     post.kit = rand(0..5)
#     post.completed = Faker::Date.between(from: 50.days.ago, to: Date.today)
#     post.duration = rand(1..300)
#     post.section = rand(6..49)
#   end
# end

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "json"
require "open-uri"

Bookmark.destroy_all
Recipe.destroy_all
Category.destroy_all

=begin
Recipe.create(
  name: "Tacos al Pastor",
  description: "Tacos al Pastor are a traditional Mexican dish made with marinated pork that's slow-cooked on a vertical rotisserie. They are served in corn tortillas and topped with pineapple, onions, cilantro, and a squeeze of lime.",
  image_url: "https://www.seriouseats.com/thmb/n4eAmpoBfbqN2Y8pU8fUxE3Y_gs=/750x0/filters:no_upscale():max_bytes(150000):strip_icc()/20210712-tacos-al-pastor-melissa-hom-seriouseats-37-f72cdd02c9574bceb1eef1c8a23b76ed.jpg",
  rating: 9.2
)
Recipe.create(
  name:"Huevos rancheros",
  description:"A Mexican-inspired vegetarian brunch of egg, tomato, avocado, kidney beans and cheese, on top of tortilla. It's spicy, filling and full of flavour",
  image_url:"https://images.immediate.co.uk/production/volatile/sites/30/2020/08/huevos-rancheros-72f825a.jpg?quality=90&webp=true&resize=375,341",
  rating: 8.7
)
Recipe.create(
  name:"Black beans & avocado on toast",
  description:"A vibrant Mexican-style breakfast with fresh avocado and black beans. Give yourself a healthy start with our easy vegan beans on toast with a twist",
  image_url:"https://images.immediate.co.uk/production/volatile/sites/30/2020/08/mexican-beans-and-avo-33f4279.jpg?quality=90&webp=true&resize=375,341",
  rating: 9.3
)
Recipe.create(
  name:"Veggie burritos",
  description:"Vegetarian burritos filled with mushrooms, beans and corn, complemented by creamy avocado and subtle spice. Enjoy with a tomato salsa on the side",
  image_url:"https://images.immediate.co.uk/production/volatile/sites/30/2023/12/211220231703163234.jpeg?quality=90&webp=true&resize=375,341",
  rating: 8.9
)
Recipe.create(
  name:"Mexican potato wedges",
  description:"Spicy, healthy potato wedges",
  image_url:"https://images.immediate.co.uk/production/volatile/sites/30/2020/08/recipe-image-legacy-id-3824_11-2823bb8.jpg?quality=90&webp=true&resize=375,341",
  rating: 8.6
)
=end

def recipe_builder(id)
  meal_url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{id}"
  meal_serialized = URI.open(meal_url).read
  meal = JSON.parse(meal_serialized )["meals"][0]
  puts "Creating #{meal["strMeal"]}"

  Recipe.create!(
    name: meal["strMeal"],
    description: meal["strInstructions"],
    image_url: meal["strMealThumb"],
    rating: rand(2..5.0).round(1)
  )
end

categories = ["Breakfast", "Pasta", "Seafood", "Dessert"]

categories.each do |category|
url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=#{category}"
recipe_list = URI.open(url).read
recipes = JSON.parse(recipe_list)
recipes["meals"].take(5).each do |recipe|
  recipe_builder(recipe["idMeal"])
end
end

puts "Done! #{Recipe.count} recipes created!"

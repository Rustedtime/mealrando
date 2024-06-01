class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def random
    numRecipes = 5
    randomRecipes = Array.new()
    for a in 1..numRecipes do
      randomnumber = 1 + rand(10)
      puts "#{randomnumber}"
      randomRecipes.push(Recipe.find(randomnumber))
    end
    @recipes = randomRecipes
  end
end

class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredientList = @recipe.ingredient.split(', ', -1)
  end

  def random
    recipes = Recipe.all
    numRecipes = 5
    randomRecipes = Array.new()
    for a in 1..numRecipes do
      randomnumber = 1 + rand(recipes.length())
      puts "#{randomnumber}"
      randomRecipes.push(recipes[randomnumber])
    end
    @recipes = randomRecipes
  end
end

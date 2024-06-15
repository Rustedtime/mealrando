class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredientList = @recipe.ingredient.split(', ', -1)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render :edit, status: :unprocessable_entity
    end
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

  private
    def recipe_params
      params.require(:recipe).permit(:name, :ingredient)
    end
end

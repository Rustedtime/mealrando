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

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to root_path, status: :see_other
  end

  def random
    data = randomize_params
    recipesList = params[:menu]
    numRecipes = params[:meals]
    randomRecipes = Array.new()
    for a in 1..numRecipes.to_i do
      randomnumber = 1 + rand(recipesList.length() - 1)
      randomRecipes.push(Recipe.find(recipesList[randomnumber]))
    end
    @recipes = randomRecipes
  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :ingredient)
    end

    def randomize_params
      params.permit(:menu).permit(:meals).permit(:repeat)
    end
end

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

  def plan
    @recipes = Recipe.all
    @errors = Array.new()
  end

  def random
    validation = randomize_params
    if (validation.empty?)
      recipesList = params[:menu]
      numRecipes = params[:meals]
      randomRecipes = Array.new()
      for a in 1..numRecipes.to_i do
        randomNumber = 1 + rand(recipesList.length() - 1)
        randomRecipes.push(Recipe.find(recipesList[randomNumber]))
        if params[:repeat].to_i == 0
          recipesList.delete_at(randomNumber)
        end
      end
      ingredientList = Set.new()
      randomRecipes.each do |recipe|
        recipeIngredients = recipe.ingredient.split(', ', -1)
        ingredientList.merge(recipeIngredients)
      end
      @recipes = randomRecipes
      @ingredients = ingredientList
    else
      @recipes = Recipe.all
      @errors = validation
      render :plan, status: :unprocessable_entity
    end
  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :ingredient)
    end

    def randomize_params
      params.permit(:menu).permit(:meals).permit(:repeat)
      errors = Array.new()
      if params[:menu].length <= 1
        errors.push("Your menu must include at least 1 meal")
      end
      if params[:meals] == ""
        errors.push("You must plan for at least 1 meal")
      end
      if (params[:repeat].to_i == 0) and ((params[:menu].length - 1) < params[:meals].to_i)
        errors.push("You need to add more meals to the pool for repeat to be disabled")
      end
      return errors
    end
end

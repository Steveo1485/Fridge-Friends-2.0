class RecipesController < ApplicationController
  def index
    @recipe = Recipe.new
    @recipes = Recipe.all
    @recipe_query = RecipeQuery.find(params[:recipe_query_id])
  end

  def show
    @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredients.split(',')
  end
end
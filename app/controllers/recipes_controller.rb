class RecipesController < ApplicationController
  def index
    response = Contentful::RecipeService.new.perform(:recipes_list)
    @recipes = response[:data]
  end

  def show
    response = Contentful::RecipeService.new.perform(:recipe_details, params[:id])
    @recipe = response[:data]
  end
end

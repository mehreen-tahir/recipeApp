class RecipesController < ApplicationController
  def index
    response = Contentful::RecipeService.new.perform(:recipes_list)
    @recipes = response[:data]
  end

  def show
  end
end

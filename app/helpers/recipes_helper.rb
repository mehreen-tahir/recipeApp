module RecipesHelper
  def recipe_image(recipe)
    recipe[:image].present? ? recipe[:image] : 'no_image.png'
  end
end

module Contentful
  class RecipeService
    CONTENT_TYPE = 'recipe'.freeze

    RESPONSE_TYPE = {
      success: 200,
      api_error: 401,
      not_found: 404,
    }.freeze

    def perform(method_name, *arguments)
      { data: self.send(method_name, *arguments), status: map_status(:success) }
    end

    private

    def recipes_list
      recipes = []

      Webservice.client.entries(content_type: CONTENT_TYPE, order: '-sys.createdAt').each_item do |recipe|
        recipes << map_recipe_fields_short(recipe.fields).merge({id: recipe.id})
      end

      recipes
    end

    def recipe_details(recipe_id)
      recipe = Webservice.client.entry(recipe_id)

      map_recipe_extended(recipe.fields)
    end

    def map_recipe_fields_short(recipe_fields)
      {
        title: recipe_fields[:title],
        image: recipe_fields[:photo] && "https:#{recipe_fields[:photo].url}"
      }
    end

    def map_recipe_extended(recipe_fields)
      {
        description: recipe_fields[:description],
        chef_name: recipe_fields[:chef] && recipe_fields[:chef].fields[:name],
        tags_list: recipe_fields[:tags] && recipe_fields[:tags].collect{ |tag| tag.fields[:name] }
      }.merge(map_recipe_fields_short(recipe_fields))
    end

    def map_status(response_type)
      key = RESPONSE_TYPE.has_key?(response_type.to_sym) ? response_type.to_sym : :api_error #fallback

      RESPONSE_TYPE[key]
    end
  end

end

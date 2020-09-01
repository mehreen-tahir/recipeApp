require 'contentful'

module Contentful
  class Webservice

    def self.client
      Contentful::Client.new(
        space: ENV['SPACE_KEY'],
        access_token: ENV['ACCESS_TOKEN'],
        environment: ENV['ENV_ID'],
        dynamic_entries: :auto
      )
    rescue => e
      e.class.to_s
    end

  end
end
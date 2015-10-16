require "grape_routes/version"

module GrapeRoutes
  @@all_routes = []

  def self.add_routes(route)
    @@all_routes << route
  end

  def self.all_routes
    @@all_routes
  end
end

module Grape
  module DSL
    module Routing
      def self.included(base)
        super

        GrapeRoutes.add_routes(base)
      end
    end
  end
end

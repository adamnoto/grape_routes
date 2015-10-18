require "grape_routes/version"
require "singleton"

module GrapeRoutes
end

module Grape::Routes
  class << self
    attr_accessor :all_routes
    attr_accessor :endpoints

    def all_routes
      parse!
      @all_routes
    end
  end

  # reparse everything
  def self.parse!
    self.endpoints = []
    Grape::API.descendants.each { |endpoint| self.endpoints << endpoint }
    self.endpoints.each { |endpoint| parse_endpoint(endpoint) }
  end

  def self.parse_endpoint(grape_api_class)
    parsable_routes = {}
    grape_api_class.routes.each do |route|
      route_path_name = route.route_path
      route_path_name = route_path_name.gsub(%r{^\/}, '')
      route_path_name = route_path_name.tr('/', '_')
      route_path_name = route_path_name.gsub(/(\(.+\))+/, '')
      route_path_name = 'index' if route_path_name.empty?
      route_path_name << '_' + route.route_method.to_s.downcase
      route_path_name << '_path'
      parsable_routes[route_path_name] = route
    end

    self.all_routes = {} if self.all_routes.nil?

    self.class_eval do
      parsable_routes.each do |route_path_name, route_object|
        next if self.all_routes[route_path_name]

        route_path = route_object.route_path.gsub(/(\(.+\))+/, '')
        if route_path_name =~ /:version_/i
          route_path_name = route_path_name.gsub(/:version_/i, '')
          self.all_routes[route_path_name] = route_object
          define_singleton_method route_path_name do |*args|
            fail 'Pass in version' if args.length != 1
            version = args[0]
            route_path.gsub(':version', version)
          end # define_singleton_method
        else
          self.all_routes[route_path_name] = route_object
          define_singleton_method route_path_name do
            route_path
          end
        end # if check
      end # each parsable_routes
    end # class_eval

    self.all_routes = all_routes
  end # parse_endpoint

  def self.method_missing(method_name, *args, &block) 
    self.parse!
    if self.respond_to?(method_name)
      self.send(method_name)
    else
      super.method_missing(method_name, *args, &block)
    end
  end

end

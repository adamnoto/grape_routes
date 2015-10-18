# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grape_routes/version'

Gem::Specification.new do |spec|
  spec.name          = "grape_routes"
  spec.version       = GrapeRoutes::VERSION
  spec.authors       = ["Adam Pahlevi"]
  spec.email         = ["adam.pahlevi@gmail.com"]

  spec.summary       = %q{Provide referable routing mechanism for your Grape API}
  spec.description   = %q{Provide referable routing mechanism for your Grape API}
  spec.homepage      = 'https://github.com/saveav/grape_routes'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end

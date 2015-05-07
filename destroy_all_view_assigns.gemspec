# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'destroy_all_view_assigns/version'

Gem::Specification.new do |spec|
  spec.name          = "destroy_all_view_assigns"
  spec.version       = DestroyAllViewAssigns::VERSION
  spec.authors       = ["Anton Shemerey"]
  spec.email         = ["shemerey@gmail.com"]

  spec.summary       = %q{This gem will force you to avoid instance instance variables in you Rails controllers}
  spec.description   = %q{Some times instance variables can be bug producers when you exidently change data somewhere in the middle.}
  spec.homepage      = "https://github.com/shemerey/destroy_all_view_assigns"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end

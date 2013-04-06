# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_model_extensions/version'

Gem::Specification.new do |spec|
  spec.name          = "active_model_extensions"
  spec.version       = ActiveModelExtensions::VERSION
  spec.authors       = ["Daniel Luxemburg"]
  spec.email         = ["daniel.luxemburg@gmail.com"]
  spec.description   = %q{Some Extension::Extensions for your ActiveModel::Models}
  spec.summary       = %q{InstanceValidatable, ValidationAlertable}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 4.0.0.beta1"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end

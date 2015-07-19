# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eve_tools/version'

Gem::Specification.new do |spec|
  spec.name          = "eve_tools"
  spec.version       = EveTools::VERSION
  spec.authors       = ["...Paul"]
  spec.email         = ["dotdotdotpaul@gmail.com"]
  spec.description   = %q{Toolbox of objects for interactin with EVE Online APIs}
  spec.summary       = %q{Toolbox of objects for interactin with EVE Online APIs}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end

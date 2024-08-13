# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enum_ish/version'

Gem::Specification.new do |spec|
  spec.name          = "enum_ish"
  spec.version       = EnumIsh::VERSION
  spec.authors       = ["Yoshikazu Kaneta"]
  spec.email         = ["kaneta@sitebridge.co.jp"]
  spec.summary       = %q{A ruby and rails extension to generate enum-like methods}
  spec.description   = %q{A ruby and rails extension to generate enum-like methods}
  spec.homepage      = "https://github.com/kanety/enum_ish"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 5.0"
  spec.add_dependency "i18n"

  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "simplecov"
end

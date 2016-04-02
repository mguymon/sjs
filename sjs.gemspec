# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sjs/version'

Gem::Specification.new do |spec|
  spec.name          = "sjs"
  spec.version       = Sjs::VERSION
  spec.authors       = ["Michael Guymon"]
  spec.email         = ["michael@tobedevoured.com"]

  spec.summary       = %q{Simple JSON Streaming}
  spec.description   = %q{Simple JSON Streaming}
  spec.homepage      = "https://github.com/mguymon/sjs"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'lock_jar', '~> 0.15'
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "yard"
end

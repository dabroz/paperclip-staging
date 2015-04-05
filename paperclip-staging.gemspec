# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paperclip/staging/version'

Gem::Specification.new do |spec|
  spec.name          = "paperclip-staging"
  spec.version       = Paperclip::Staging::VERSION
  spec.authors       = ["Tomasz Dąbrowski"]
  spec.email         = ["t.dabrowski@rock-hard.eu"]
  spec.summary       = %q{Allow Paperclip to pass attachments as data-uri on unsaved records.}
  spec.description   = %q{Allow Paperclip to pass attachments as data-uri on unsaved records. Useful when dealing with forms and validation errors.}
  spec.homepage      = "https://github.com/dabroz/paperclip-staging"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'paperclip', '~> 4.2'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end

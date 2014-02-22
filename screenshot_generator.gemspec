# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'screenshot_generator/version'

Gem::Specification.new do |spec|
  spec.name          = "screenshot_generator"
  spec.version       = ScreenshotGenerator::VERSION
  spec.authors       = ["Tom Lea"]
  spec.email         = ["commit@tomlea.co.uk"]
  spec.summary       = %q{A simple wrapper around FFMpeg for extracing screen shots}
  spec.homepage      = "https://github.com/cwninja/screenshot_generator"
  spec.license       = "WTFBPPL"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "chunky_png"
end

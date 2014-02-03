# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mplayer_screenshot_generator/version'

Gem::Specification.new do |spec|
  spec.name          = "mplayer_screenshot_generator"
  spec.version       = MplayerScreenshotGenerator::VERSION
  spec.authors       = ["Tom Lea"]
  spec.email         = ["commit@tomlea.co.uk"]
  spec.summary       = %q{A simple wrapper around FFMpeg for extracing screen shots}
  spec.description   = %q{A simple wrapper around FFMpeg for extracing screen shots}
  spec.homepage      = ""
  spec.license       = "WTFBPPL"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end

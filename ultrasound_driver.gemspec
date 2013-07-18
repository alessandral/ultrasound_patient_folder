# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ultrasound_driver/version'

Gem::Specification.new do |spec|
  spec.name          = "ultrasound_driver"
  spec.version       = UltrasoundDriver::VERSION
  spec.authors       = ["Alessandra Lopiano"]
  spec.email         = ["alopiano@promedicalinc.com"]
  spec.description   = %q{Extract ultrasound files to be moved to a final Network destination}
  spec.summary       = %q{Given a directory where to extract ultrasound files copy them to a final destination as date_of_service/Patient name/Files}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'duplicated_filename_checker/version'

Gem::Specification.new do |spec|
  spec.name          = "duplicated_filename_checker"
  spec.version       = DuplicatedFilenameChecker::VERSION
  spec.authors       = ["Shinya131"]
  spec.email         = ["nagai3mt5b@gmail.com"]
  spec.summary       = "This gem is check duplicated filename in multiple directory."
  spec.description   = "duplicated_filename_checker is check duplicated filename in multiple directory with subdirectory."
  spec.homepage      = "https://github.com/Shinya131/duplicated_filename_checker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end

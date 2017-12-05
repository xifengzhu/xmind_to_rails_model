# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'xmind_to_rails_model/version'

Gem::Specification.new do |spec|
  spec.name          = "xmind_to_rails_model"
  spec.version       = XmindToRailsModel::VERSION
  spec.authors       = ["xifengzhu"]
  spec.email         = ["xifengzhu520@gmail.com"]

  spec.summary       = "convert xmind file o rails model"
  spec.description   = "convert xmind file o rails model"
  spec.homepage      = "https://github/xifengzhu/xmind_to_rails_model"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "bin"
  spec.executables   = "xmind_to_rails_model"
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", '>= 3.2'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

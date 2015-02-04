# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elephant/version'

Gem::Specification.new do |gem|
  gem.name          = "elephant"
  gem.version       = Elephant::VERSION
  gem.authors       = ["Christoph Sassenberg"]
  gem.email         = ["christoph.sassenberg@googlemail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = "http://github.com/defsprite/elephant"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'pg', '~> 0.11'
  # gem.add_dependency 'activerecord'
  gem.add_dependency 'slim'
  gem.add_dependency 'sinatra'
  gem.add_dependency 'sinatra-partial'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'watchr'
  gem.add_development_dependency 'activerecord'


end

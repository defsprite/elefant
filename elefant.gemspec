# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elephant/version'

Gem::Specification.new do |gem|
  gem.name          = "elefant"
  gem.version       = Elephant::VERSION
  gem.authors       = ["Christoph Sassenberg"]
  gem.email         = ["christoph.sassenberg@googlemail.com"]
  gem.description   = %q{The elefant gem gives you a few insights analytics about your PostgreSQL database}
  gem.summary       = %q{Know your PostgreSQL database}
  gem.homepage      = "http://github.com/defsprite/elefant"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'pg', '~> 0.15'
  gem.add_dependency 'sinatra'
  gem.add_dependency 'sinatra-partial'
  gem.add_dependency 'i18n'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'watchr'
  gem.add_development_dependency 'activerecord'
  gem.add_development_dependency 'sass'
end

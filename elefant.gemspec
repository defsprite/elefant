# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'elefant/version'

Gem::Specification.new do |gem|
  gem.name          = "elefant"
  gem.version       = Elefant::VERSION
  gem.authors       = ["Christoph Sassenberg"]
  gem.email         = ["christoph.sassenberg@googlemail.com"]
  gem.description   = %q{The elefant gem gives you a few insights analytics about your PostgreSQL database}
  gem.summary       = %q{Know your PostgreSQL database}
  gem.homepage      = "http://github.com/defsprite/elefant"
  gem.licenses      = ["MIT"]

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'pg', '~> 0.15'
  gem.add_dependency 'sinatra', '~> 1.4'
  gem.add_dependency 'sinatra-partial', '~> 0.4'
  gem.add_dependency 'i18n', '~> 0.7'

  gem.add_development_dependency 'rake', '~> 10.4'
  gem.add_development_dependency 'minitest', '~> 5.5'
  gem.add_development_dependency 'rack-test', '~> 0.6'
  gem.add_development_dependency 'watchr', '~> 0.7'
  gem.add_development_dependency 'activerecord', '~> 4.2'
  gem.add_development_dependency 'sass', '~> 3.4'
end

# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'validates_overlap'
  s.version = File.read('VERSION')

  s.authors = ['Robin Bortlik']
  s.date = '2013-10-18'
  s.description = 'It can be useful when you you are developing some app where you will work with meetings, events etc.'
  s.email = 'robinbortlik@gmail.com'
  s.extra_rdoc_files = [
    'README.md'
  ]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/dummy/spec/*`.split("\n")

  s.homepage = 'http://github.com/robinbortlik/validates_overlap'
  s.licenses = ['MIT']
  s.require_paths = ['lib']
  s.summary = 'This gem helps validate records with time overlap.'
  s.add_dependency 'rails', '>= 3.0.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rb-readline'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'test-unit'
end

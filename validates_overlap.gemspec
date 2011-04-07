# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = "validates_overlap"
  s.summary = "This gem helps validate records with time overlap."
  s.description = "It can be useful when you you are developing some app where you will work with meetings, events etc."
  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.rdoc"]
  s.version = "0.0.1"
  s.email = "robinbortlik@gmail.com"
  s.homepage = "https://github.com/robinbortlik/validates_overlap"
  s.authors = ["Robin Bortlik"]
end
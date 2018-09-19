$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "quick_search/fedora_searcher/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'quick_search-fedora_searcher'
  s.version     = QuickSearchFedoraSearcher::VERSION
  s.authors     = ['UMD Libraries']
  s.email       = ['lib-ssdr@umd.edu']
  s.homepage    = 'https://www.lib.umd.edu/'
  s.summary     = 'Fedora searcher for NCSU Quick Search.'
  s.description = 'Fedora searcher for NCSU Quick Search.'
  s.license     = 'Apache 2.0'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'quick_search-core', '~> 0'
  s.add_development_dependency 'rubocop', '= 0.52.1'
  # sqlite3 loaded for testing with the "dummy" application
  s.add_development_dependency 'sqlite3'
end

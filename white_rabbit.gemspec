$:.push File.expand_path('lib', __dir__)

require 'white_rabbit/version'

Gem::Specification.new do |s|
  s.name        = 'white_rabbit'
  s.version     = WhiteRabbit::VERSION
  s.authors     = ['Can Eldem']
  s.email       = ['eldemcan@gmail.com']
  s.homepage    = 'https://github.com/eldemcan'
  s.summary     = 'Frontend for scheduling and managing reoccurring jobs'
  s.description = 'Frontend for scheduling and managing reoccurring jobs rails engine based of rufus gem'
  s.license     = 'MIT'
  s.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'cron2english', '~> 0.1.6'
  s.add_dependency 'cronter', '~> 0.1.2'
  s.add_dependency 'plissken', '~> 1.3'
  s.add_dependency 'rails', '~> 6.0.3.1'
  s.add_dependency 'rufus-scheduler', '~> 3.6'
  s.add_dependency 'sqlite3', '~> 1.4'

  s.add_development_dependency 'byebug', '~> 11.1'
  s.add_development_dependency 'factory_bot_rails', '~> 6.1'
  s.add_development_dependency 'rspec-rails', '~> 4.0'
  s.add_development_dependency 'single_cov', '~> 1.3 '
end

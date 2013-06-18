
# encoding: utf-8
require File.expand_path('../lib/oj/pstore/version', __FILE__)

GemSpec= Gem::Specification.new do |spec|
  spec.required_rubygems_version= Gem::Requirement.new('>= 1.3.6')
	spec.name= 'oj-pstore'
	spec.version= Oj::PStore::VERSION
	spec.date= Time.now.strftime('%Y-%m-%d')
	spec.authors= ['Mike Blumtritt']
#	spec.email= ''
	spec.summary= 'PStore based on fast JSON parser/marshaller Oj.'
	spec.description= 'This gem implements a PStore alternative using the fast Oj gem.'
	spec.homepage= 'https://github.com/mblumtritt/oj-pstore'
	spec.platform= Gem::Platform::RUBY
	spec.required_ruby_version= '>= 1.9.3'
  spec.add_dependency 'oj'
  spec.add_development_dependency 'test-unit'
	spec.has_rdoc= false # TODO: we need a RDOC!
	spec.extra_rdoc_files= ['README.md']
	spec.files<< Dir['lib/**/*.rb']
  spec.files<< Dir['test/**/*.rb']
	spec.files<< 'README.md'
	spec.files<< 'Gemfile'
	spec.files<< 'Gemfile.lock'
end

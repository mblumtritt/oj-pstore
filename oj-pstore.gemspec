require_relative 'lib/oj/store'

GemSpec = Gem::Specification.new do |spec|
  spec.name = 'oj-pstore'
  spec.version = Oj::Store::VERSION
  spec.summary = 'PStore based on fast JSON parser/marshaller Oj.'
  spec.description =
    'This gem implements a PStore alternative using the very fast Oj gem.'
  spec.author = 'Mike Blumtritt'
  spec.email = 'mike.blumtritt@pm.me'
  spec.homepage = 'https://github.com/mblumtritt/oj-pstore'
  spec.metadata = {
    'source_code_uri' => 'https://github.com/mblumtritt/tcp-client',
    'bug_tracker_uri' => 'https://github.com/mblumtritt/tcp-client/issues'
  }

  spec.add_dependency 'oj'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rake'

  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.0.0'
  spec.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')

  spec.require_paths = %w[lib]

  all_files = %x(git ls-files -z).split(0.chr)
  spec.test_files = all_files.grep(%r{^(spec|test)/})
  spec.files = all_files - spec.test_files

  spec.extra_rdoc_files = %w[README.md]
end

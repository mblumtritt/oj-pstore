# frozen_string_literal: true

require_relative 'lib/oj/store'

GemSpec = Gem::Specification.new do |spec|
  spec.name = 'oj-pstore'
  spec.version = Oj::Store::VERSION
  spec.summary = 'PStore based on fast JSON parser/marshaller Oj.'
  spec.description =
    'This gem implements a PStore alternative using the very fast Oj gem.'

  spec.author = 'Mike Blumtritt'
  spec.homepage = 'https://github.com/mblumtritt/oj-pstore'
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['bug_tracker_uri'] = "#{spec.homepage}/issues"

  spec.required_ruby_version = '>= 2.0.0'
  spec.add_runtime_dependency 'oj'
  spec.files = Dir['lib/**/*']
  spec.extra_rdoc_files = %w[README.md]
end

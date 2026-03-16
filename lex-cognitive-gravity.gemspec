# frozen_string_literal: true

require_relative 'lib/legion/extensions/cognitive_gravity/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-cognitive-gravity'
  spec.version       = Legion::Extensions::CognitiveGravity::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX Cognitive Gravity'
  spec.description   = 'Attractor basins in thought space — cognitive gravity wells for LegionIO agentic AI'
  spec.homepage      = 'https://github.com/LegionIO/lex-cognitive-gravity'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']        = spec.homepage
  spec.metadata['source_code_uri']     = 'https://github.com/LegionIO/lex-cognitive-gravity'
  spec.metadata['documentation_uri']   = 'https://github.com/LegionIO/lex-cognitive-gravity'
  spec.metadata['changelog_uri']       = 'https://github.com/LegionIO/lex-cognitive-gravity'
  spec.metadata['bug_tracker_uri']     = 'https://github.com/LegionIO/lex-cognitive-gravity/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.start_with?('spec/') }
  spec.require_paths = ['lib']
  spec.add_development_dependency 'legion-gaia'
end

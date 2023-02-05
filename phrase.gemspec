# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'phrase/version'

Gem::Specification.new do |spec|
  spec.name = 'phrase'
  spec.version = Phrase::VERSION
  spec.authors = ['Igor Arkhipov']
  spec.email = ['igor.arkhipov@gmail.com']

  spec.summary = 'This gem extends i18n to allow fetching translation files via HTTP'
  spec.description = 'This library supports fetching translation files via HTTP rather than just relying
  on local translation files and falls back in case of network issues.'
  spec.homepage = 'https://github.com/IgorArkhipov'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://github.com/IgorArkhipov'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
          'public gem pushes.'
  end

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/IgorArkhipov'
  spec.metadata['changelog_uri'] = 'https://github.com/IgorArkhipov'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'faraday'
  spec.add_dependency 'httpx'
  spec.add_dependency 'i18n'
  spec.add_dependency 'psych', '~> 4.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-minitest'
  spec.add_development_dependency 'rubocop-rake'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end

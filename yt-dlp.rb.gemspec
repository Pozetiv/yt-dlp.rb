# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yt-dlp/version'

Gem::Specification.new do |spec|
  spec.name          = 'yt-dlp.rb'
  spec.version       = YtDlp::VERSION
  spec.authors       = %w[andrepcg]
  spec.email         = ['andrepcg@gmail.com']
  spec.summary       = 'yt-dlp wrapper for Ruby'
  spec.description   = 'yt-dlp.rb is a command line wrapper for the python script yt-dlp'
  spec.homepage      = 'https://github.com/andrepcg/yt-dlp.rb'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.6'

  spec.add_dependency 'terrapin', '>=0.6.0'

  spec.add_development_dependency 'bundler', '>= 1.6'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'minitest', '~> 5.14.3'
  spec.add_development_dependency 'purdytest'
  spec.add_development_dependency 'rake', '~> 10.0'
end

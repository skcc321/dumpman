# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dumpman/version'

Gem::Specification.new do |spec|
  spec.name          = 'dumpman'
  spec.version       = Dumpman::VERSION
  spec.authors       = ['rafael']
  spec.email         = ['skcc321@gmail.com']

  spec.summary       = %q{gem for playing with dumps}
  spec.description   = %q{it dumps}
  spec.homepage      = 'https://github.com/skcc321/dumpman'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata['allowed_push_host'] = 'https://github.com/skcc321/dumpman'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '>= 4.2.8'
  spec.add_dependency 'rake', '>= 12.1.0'

  spec.add_development_dependency 'bundler', '>= 1.15'
  spec.add_development_dependency 'mysql2'
  spec.add_development_dependency 'pg', '>= 0.18.4'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rspec', '>= 3.5.0'
  spec.add_development_dependency 'simplecov'

  # danger
  spec.add_development_dependency 'danger'
  spec.add_development_dependency 'danger-pronto'
  spec.add_development_dependency 'pronto'
  spec.add_development_dependency 'pronto-brakeman'
  spec.add_development_dependency 'pronto-fasterer'
  spec.add_development_dependency 'pronto-flay'
  spec.add_development_dependency 'pronto-poper'
  spec.add_development_dependency 'pronto-rails_best_practices'
  spec.add_development_dependency 'pronto-rails_schema'
  spec.add_development_dependency 'pronto-reek'
  spec.add_development_dependency 'pronto-rubocop'
end

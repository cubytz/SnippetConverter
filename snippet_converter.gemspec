
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snippet_converter/version'

Gem::Specification.new do |spec|
  spec.name          = 'snippet_converter'
  spec.version       = SnippetConverter::VERSION
  spec.authors       = ['Jeremie Henri']
  spec.email         = ['jeremie@cubytz.com']

  spec.summary       = 'Simple Ruby Gem that convert Sublime Text Snippets to Visual Studio Code format'
  spec.description   = 'Simple Ruby Gem that convert Sublime Text Snippets to Visual Studio Code format'
  spec.homepage      = 'https://github.com/cubytz/SnippetConverter'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files         = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.bindir        = '/usr/bin'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end

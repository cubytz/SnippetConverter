
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'snippet_converter/version'

Gem::Specification.new do |spec|
  spec.name          = 'snippet_converter'
  spec.version       = SnippetConverter::VERSION
  spec.authors       = ['Jeremie Henri']
  spec.email         = ['jeremie@cubytz.com']

  spec.summary       = 'CLI Converter for Sublime Snippets to Visual Studio Code format'
  spec.description   = 'Simple command-line tool to convert Sublime Text Snippets to Visual Studio Code format'
  spec.homepage      = 'https://github.com/cubytz/SnippetConverter'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end

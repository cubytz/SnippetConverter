# SnippetConverter

[![The MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](http://opensource.org/licenses/MIT)

Simple command-line tool to convert Sublime Text Snippets to Visual Studio Code format

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'snippet_converter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install snippet_converter

## Usage

### Simple conversion

Convert a snippet to json

```
snippet_converter -f PATH_TO_SUBLIME_SNIPPET
```

This will create a `snippets/snippets.json` file in the current working directory.

**Keep original filename**

Pass the split `-s` option to keep the original filename.

### Bulk conversion

**Convert selected files**

Convert multiple files by passing a comma seperated list to the `-f` option

```
snippet_converter -f 'PATH_TO_FILE,PATH_TO_FILE,...'
```

**Convert content of directory**

Convert a folder by using the `-d` option

```
snippet_converter -d PATH_TO_DIRECTORY
```

**Split files**

Pass the split `-s` option to split the output in multiple files

### Output directory

Set the output directory by passing the `-o` option

```
snippet_converter -f PATH_TO_SNIPPET_FILE -o PATH_TO_OUTPUT_FOLDER
```

For all available options, see `-h` or `--help` for details

## Development

After checking out the repo, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cubytz/snippet_converter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SnippetConverter project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/cubytz/snippet_converter/blob/master/CODE_OF_CONDUCT.md).

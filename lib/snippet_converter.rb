#!/usr/bin/ruby -w
# frozen_string_literal: true

require 'rexml/document'
require 'optparse'
require 'optparse/time'
require 'ostruct'
require 'pp'
require 'json'
require 'fileutils'
require 'snippet_converter/version'

# The main class
class SnippetConverter
  include REXML

  # variable referencing the corresponding
  # keys {Sublime: 'VSC'}
  KEYS = {
    content: 'body',
    tabTrigger: 'prefix',
    scope: 'scope',
    description: 'description'
  }.freeze

  #
  # Parse arguments
  #
  # @param [Array] args Array of arguments passed in cli
  #
  # @return [OpenStruct] options as a ostruct
  #
  def self.parse(args)
    options = OpenStruct.new
    options.encoding = 'utf8'
    options.verbose = false
    options.split = false
    options.output = 'json'
    options.dest = 'snippets'

    opts = OptionParser.new do |op|
      op.separator ''
      op.banner = "SnippetConverter, version #{VERSION}"
      op.banner = "#{Gem.loaded_specs['snippet_converter'].license} License"
      op.banner = 'Copyright (c) 2018 Jeremie Henri - Cubytz'

      op.separator ''
      op.banner = "Usage:\tsnippetconverter.rb [options]\n\tFile(s) or directory required"

      op.separator ''
      op.separator 'Specific options:'

      # File
      op.on('-f', '--file file', 'Snippet file(s) to convert') do |f|
        options.file = f
      end

      # Directory
      op.on('-d', '--directory directory', 'Directory of snippets file to convert') do |d|
        options.directory = d
      end

      # Split
      op.on('-s', '--[no-]split', 'Split output into multiple files') do |s|
        options.split = s
      end

      # Output
      op.on('-o', '--output output', 'Output format (json)') do |o|
        options.output = o
      end

      # Destination folder
      op.on('--destination destination', 'Destination directory (snippets)') do |dest|
        options.destination = dest
      end

      # Verbose
      op.on('-v', '--[no-]verbose', 'Run verbosely') do |v|
        options.verbose = v
      end

      op.separator ''
      op.separator 'Common options:'

      # Print an options summary.
      op.on_tail('-h', '--help', 'Show this help message') do
        puts opts
        exit
      end

      # Print the version.
      op.on_tail('--version', 'Show version') do
        puts "SnippetConverter, version #{VERSION}"
        exit
      end
    end

    opts.parse!(args)
    options
  end

  #
  # Read snippet file and return the first snippet found
  #
  # @param [String] file Snipppet file path
  #
  # @return [REXML::Element] First snippet element found
  #
  def self.read_snippet(file)
    xmlfile = File.new(file)
    doc = Document.new(xmlfile)

    # return the snippet element
    XPath.first(doc.root, '//snippet')
  end

  #
  # Creates a Hash element with VSC keys and
  # formatted body
  #
  # @param [REXML::Element] snippet_element Snippet xml element
  #
  # @return [Hash] Snippet as a hash
  #
  def self.create_json_snippet(snippet_element)
    snippet = {}
    snippet_element.elements.each do |element|
      key = KEYS[element.name.to_sym]
      case key
      when 'body'
        value = SnippetConverter.format_body(element.text)
      else
        value = element.text
      end

      snippet[key.to_sym] = value
    end
    snippet
  end

  #
  # Convert file content to VSC snippet format
  #
  # @param [file] file Snippet file path
  #
  # @return [Hash] VSC Json snippet
  #
  def self.convert_to_vsc(file)
    # Get the first snippet element
    snippet_element = read_snippet(file)
    # Convert the snippet to VSC snippet format
    create_json_snippet(snippet_element)
  end

  #
  # Format the body element
  #
  # @param [String] body Sublime snippet content element
  #
  # @return [Array] Body as an array
  #
  def self.format_body(body)
    # Split by \n
    formatted_body = body.split("\n")
    # Remove any empty element from the array
    formatted_body.delete('')
    formatted_body
  end

  #
  # Save snippet content to disk
  #
  # @param [String] file filename
  # @param [Has] snippet snippet hash
  #
  def self.write_file(file, snippet)
    File.open(file, 'w') do |f|
      # Pretty generate the JSON before saving
      f.write(JSON.pretty_generate(snippet))
    end
  end
end

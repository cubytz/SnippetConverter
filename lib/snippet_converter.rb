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

  VERSION = 0.1
  KEYS = {
    content: 'body',
    tabTrigger: 'prefix',
    scope: 'scope',
    description: 'description'
  }.freeze

  def self.parse(args)
    options = OpenStruct.new
    options.encoding = 'utf8'
    options.verbose = false
    options.split = false
    options.output = 'snippets'

    opts = OptionParser.new do |op|
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

      # Output folder
      op.on('-o', '--output output', 'Output directory [snippets]') do |o|
        options.output = o
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

  def self.convert(file)
    xmlfile = File.new(file)
    doc = Document.new(xmlfile)

    # Now get the root element
    root = doc.root

    # Info for the first snippet found
    snippet_element = XPath.first(root, '//snippet')
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

  def self.format_body(body)
    formatted_body = body.split("\n")
    formatted_body.delete('')
    formatted_body
  end

  def self.output_file(file, snippet)
    File.open(file, 'w') do |f|
      f.write(JSON.pretty_generate(snippet))
    end
  end
end

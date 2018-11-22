# frozen_string_literal: true

require 'thor'

Signal.trap(:INT) do
  # respect https://twitter.com/toshi_a
  puts "\nThis process has been suspended."
  exit 0
end

# CLI command interface
class CLI < Thor
  package_name 'mikutter-cli'

  require_relative './command'
end

CLI.start ARGV

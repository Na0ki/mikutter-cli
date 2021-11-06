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

  class << self
    # https://github.com/rails/thor/blob/fb625b223465692a9d8a88cc2a483e126f1a8978/CHANGELOG.md#100
    def exit_on_failure?
      true
    end
  end
end

CLI.start ARGV

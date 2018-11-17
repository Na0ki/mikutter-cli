# frozen_string_literal: true

require 'highline'
require 'ostruct'
require 'thor'
require 'yaml'
require_relative './model'
require_relative './template'

Signal.trap(:INT) do
  # respect https://twitter.com/toshi_a
  puts "\nThis process has been suspended."
  exit 0
end

# execute
def run
  cli = HighLine.new
  config = Config.new
  depends = Depends.new

  loop do
    config.ask cli
    depends.ask cli

    config.depends = depends

    cli.say 'Check your config!'

    cli.say config.to_h_k_s.to_yaml

    break if cli.agree 'Ready to start?'
  end

  MikutterCLI::Template.generate_plugin 'plugin.erb', config
end

# CLI command interface
class CLI < Thor
  package_name 'mikutter-cli'

  desc 'new PLUGIN_NAME', 'Creates a new plugin'
  method_option :help, aliases: '-h', desc: 'show help'
  def new(plugin_name)
    help = options[:help]

    if help
      # TODO: show help
    else
      puts "Configuring #{plugin_name}"
      run
    end
  end
end

CLI.start

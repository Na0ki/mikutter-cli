# frozen_string_literal: true

require 'thor'
require 'yaml'
require 'highline'

require_relative '../model'
require_relative '../template'
require_relative '../model/config'
require_relative '../model/depends'

# generate plugin & plugin config
class CLI < Thor
  desc 'new PLUGIN_NAME', 'Creates a new plugin'
  options name: :required
  def new(slug)
    help = options[:help]

    if help
      # TODO: show help
    else
      @slug = slug
      @name = options[:name]
      @version = options[:version]
      @author = options[:author]
      @description = options[:description]
      @mikutter = options[:mikutter]

      generate
    end
  end


  no_commands do
    private

    # ask & generate plugin config
    def generate
      config = Config.new
      config.slug = @slug
      config.name = @name
      config.version = @version
      config.author = @author
      config.description = @description
      config.depends.mikutter = @mikutter

      puts "Configuring #{@slug}"

      loop do
        config.ask

        puts 'Check your config!'
        puts ''
        puts config.to_h_k_s.to_yaml
        puts ''

        break if HighLine.new.agree 'Ready to start?'
      end

      MikutterCLI::Template.generate_plugin 'plugin.erb', config
    end
  end
end

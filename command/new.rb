# frozen_string_literal: true

require 'thor'
require 'yaml'
require 'open3'
require 'shellwords'

require_relative '../model'
require_relative '../template'
require_relative '../model/config'
require_relative '../model/depends'

# generate plugin & plugin config
class CLI < Thor
  desc 'new PLUGIN_NAME', 'Creates a new plugin'
  method_option :name, type: :string
  method_option :author, type: :string
  method_option :description, type: :string, aliases: '-d'
  method_option :version, type: :string
  method_option :mikutter, type: :string
  method_option :git, type: :boolean, default: true
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
      @git = options[:git]

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

      config.ask

      puts ''
      puts config.to_h_k_s.to_yaml
      puts ''

      dir = MikutterCLI::Template.generate_plugin 'plugin.erb', config
      git_init dir
    end

    def git_init(dir)
      o, e, s = Open3.capture3("cd #{dir.to_s.shellescape} && git init") if @git
      puts s.success? ? o : e
    end
  end
end

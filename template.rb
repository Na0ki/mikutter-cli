# frozen_string_literal: true

require 'erb'
require 'fileutils'
require 'ostruct'
require 'pathname'
require 'yaml'

module MikutterCLI
  # Handle template
  class Template
    class << self
      TEMPLATE_DIR = Pathname(__dir__) / 'template'

      # conf root of mikutter
      # @param root
      # @return Pathname
      def conf_root(root = nil)
        Pathname(File.expand_path(root || Environment::CONFROOT || ENV['MIKUTTER_CONFROOT'] || '~/.mikutter'))
      rescue
        Pathname(File.expand_path(ENV['MIKUTTER_CONFROOT'] || '~/.mikutter'))
      end

      # load ERB template
      # @param filename template filename
      # @param model
      # @return ERB
      def load(filename, model)
        erb = File.read TEMPLATE_DIR / filename
        ERB.new(erb).result(OpenStruct.new(model.to_h).instance_eval { binding })
      end

      # generate plugin
      # @param filename
      # @param model
      def generate_plugin(filename, model)
        plugin = load filename, model
        plugin_dir = conf_root / 'plugin' / model.slug
        FileUtils.mkdir_p(plugin_dir)
        File.open(plugin_dir / '.mikutter.yml', 'w') { |f| YAML.dump model.to_h_k_s, f }
        File.open(plugin_dir / "#{model.slug}.rb", 'w') { |f| f.puts plugin }
        puts "Plugin has been generated at #{plugin_dir}"
      rescue StandardError => e
        p e
      end
    end
  end
end

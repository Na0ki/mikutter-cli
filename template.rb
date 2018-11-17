# frozen_string_literal: true

require 'erb'
require 'fileutils'
require 'yaml'

module MikutterCLI
  # Handle template
  class Template
    LOAD_DIR = File.join File.path(__dir__), 'template'

    def self.confroot
      Environment::CONFROOT || ENV['MIKUTTER_CONFROOT'] || '~/.mikutter'
    rescue
      ENV['MIKUTTER_CONFROOT'] || '~/.mikutter'
    end

    def self.load(filename, model)
      erb = File.read File.join(LOAD_DIR, filename)
      ERB.new(erb).result(OpenStruct.new(model.to_h).instance_eval { binding })
    end

    def self.write(filename, model)
      plugin = load filename, model
      puts File.expand_path(confroot)
      plugin_dir = File.join File.expand_path(confroot), 'plugin', model.slug
      puts plugin_dir
      FileUtils.mkdir_p(plugin_dir)
      File.write File.join(plugin_dir, "#{model.slug}.rb"), plugin
    end

    def self.generate_plugin(filename, model)
      plugin = load filename, model
      plugin_dir = File.join File.expand_path(confroot), 'plugin', model.slug
      FileUtils.mkdir_p(plugin_dir)
      File.open(File.join(plugin_dir, '.mikutter.yml'), 'w') { |f| YAML.dump model.to_h_k_s, f }
      File.write File.join(plugin_dir, "#{model.slug}.rb"), plugin
      puts "Plugin has been generated at #{plugin_dir}"
    rescue StandardError => e
      puts e.message
    end
  end
end

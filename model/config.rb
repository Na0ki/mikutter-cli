# frozen_string_literal: true

require 'diva'
require_relative './depends'

# Model for .mikutter.yml
class Config < Diva::Model
  field.string :slug, required: true
  field.has    :depends, Depends
  field.string :name, required: true
  field.string :version, required: true
  field.string :author, required: true
  field.string :description, required: true

  def initialize; end

  attr_writer :depends
  attr_reader :slug

  def ask(cli)
    @slug = cli.ask 'What is your plugin slug?' do |q|
      q.validate = /[\w\-]+/
      q.default = @slug unless @slug.nil?
    end

    @name = cli.ask 'What is your plugin name?' do |q|
      q.validate = /[\w\-]+/
      q.default = @name unless @name.nil?
    end

    @version = cli.ask 'What is your plugin version?' do |q|
      q.validate = /\d\.\d(\.\d)?/
      q.default = @version.nil? ? '0.0.1' : @version
    end

    @author = cli.ask 'Who is the author?' do |q|
      q.default = @author unless @author.nil?
    end

    @description = cli.ask 'Tell me what is this plugin for?' do |q|
      q.default = @description unless @description.nil?
    end
  end

  def to_h
    {
      slug: @slug, depends: @depends.to_h, name: @name,
      version: @version, author: @author, description: @description
    }
  end

  # to_h with key string
  def to_h_k_s
    {
      slug: @slug, depends: @depends.to_h_k_s, name: @name,
      version: @version, author: @author, description: @description
    }.map { |k, v| [k.to_s, v] }.to_h
  end
end

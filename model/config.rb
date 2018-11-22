# frozen_string_literal: true

require 'diva'
require 'highline'
require_relative './depends'

# Model for .mikutter.yml
class Config < Diva::Model
  field.string :slug, required: true
  field.has    :depends, Depends
  field.string :name, required: true
  field.string :version, required: true
  field.string :author, required: true
  field.string :description, required: true

  attr_accessor :slug
  attr_writer :name
  attr_writer :version
  attr_writer :author
  attr_writer :description
  attr_accessor :depends

  def initialize
    @cli = HighLine.new
    @depends = Depends.new
    @version = '0.0.1'
  end

  def ask
    @slug = @cli.ask('What is your plugin slug?') { |q| q.default = @slug unless @slug.nil? }
    @name = @cli.ask('What is your plugin name?') { |q| q.default = @name unless @name.nil? }
    @version = @cli.ask('What is your plugin version?') { |q| q.default = @version unless @version.nil? }
    @author = @cli.ask('Who is the author?') { |q| q.default = @author unless @author.nil? }
    @description = @cli.ask('Tell me what is this plugin for?') { |q| q.default = @description unless @description.nil? }
    @depends.ask
  end

  def to_h
    {
      slug: @slug, depends: @depends&.to_h, name: @name,
      version: @version, author: @author, description: @description
    }
  end

  # to_h with key string
  def to_h_k_s
    {
      slug: @slug, depends: @depends&.to_h_k_s, name: @name,
      version: @version, author: @author, description: @description
    }.map { |k, v| [k.to_s, v] }.to_h
  end
end

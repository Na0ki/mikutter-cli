# frozen_string_literal: true

require 'diva'
require 'highline'

# Model for Depends used in Config
class Depends < Diva::Model
  field.string :mikutter
  field.string :plugin

  attr_writer :mikutter

  def initialize
    @plugin = []
    @mikutter = '3.6'
    @cli = HighLine.new
  end

  def ask
    @mikutter = @cli.ask('What mikutter version do you need?') { |q| q.default = @mikutter unless @mikutter.nil? }
  end

  def to_h
    { mikutter: @mikutter, plugin: @plugin }
  end

  # to_h with key string
  def to_h_k_s
    to_h.map { |k, v| [k.to_s, v] }.to_h
  end
end

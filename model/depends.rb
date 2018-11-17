# frozen_string_literal: true

require 'diva'

# Model for Depends used in Config
class Depends < Diva::Model
  field.string :mikutter
  field.string :plugin

  def initialize
    @plugin = []
  end

  def ask(cli)
    @mikutter = cli.ask 'What mikutter version do you need?' do |q|
      q.validate = /\d\.\d(\.\d)?/
      q.default = @mikutter.nil? ? '3.6' : @mikutter
    end
  end

  def to_h
    { mikutter: @mikutter, plugin: @plugin }
  end

  # to_h with key string
  def to_h_k_s
    to_h.map { |k, v| [k.to_s, v] }.to_h
  end
end

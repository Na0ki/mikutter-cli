# frozen_string_literal: true

require 'pathname'

Dir[Pathname(__dir__) / 'command' / '*.rb'].each { |file| require file }

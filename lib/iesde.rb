require "iesde/version"
require "iesde/config"
require 'active_support/core_ext/module/attribute_accessors'

module Iesde

  mattr_accessor :config

  def self.configure
    self.config ||= Iesde::Config.new
    yield(config) if block_given?
  end
  
end

module NsOptions
  autoload :HasOptions,     'ns-options/has_options'
  autoload :Proxy,          'ns-options/proxy'
  autoload :Helper,         'ns-options/helper'
  autoload :Namespace,      'ns-options/namespace'
  autoload :Namespaces,     'ns-options/namespaces'
  autoload :Option,         'ns-options/option'
  autoload :Options,        'ns-options/options'
  autoload :VERSION,        'ns-options/version'

  module Errors
    autoload :InvalidName, 'ns-options/errors/invalid_name'
  end

  def self.included(receiver)
    receiver.send(:include, HasOptions)
  end

end

$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))

require 'logger'
require 'ns-options'

require 'test/support/app'
require 'test/support/user'

require 'assert-mocha'

module NsOptions
  module TestOutput

    module_function

    def capture
      out = StringIO.new
      $stdout = out
      yield
      return out
    ensure
      $stdout = STDOUT
    end

  end
end


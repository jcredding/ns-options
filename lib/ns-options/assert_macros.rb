module NsOptions; end
module NsOptions::AssertMacros

  # a set of Assert macros to help write namespace definition and
  # regression tests in Assert (https://github.com/teaminsight/assert)

  def self.included(receiver)
    receiver.class_eval do
      extend MacroMethods
    end
  end

  module MacroMethods

    def have_namespaces(*namespaces)
      called_from = caller.first
      macro_name = "have namespaces: #{namespaces.map{|ns| "'#{ns}'"}.join(', ')}"

      Assert::Macro.new(macro_name) do
        namespaces.each do |ns|
          should "have a namespace named '#{ns}'", called_from do
            assert_respond_to ns, subject
            assert_kind_of NsOptions::Namespace, subject.send(ns)
          end
        end
      end
    end
    alias_method :have_namespace, :have_namespaces

    def have_options(*options)
      called_from = caller.first
      macro_name = "have options: #{options.map{|opt| "'#{opt}'"}.join(', ')}"

      Assert::Macro.new(macro_name) do
        options.each do |opt|
          should "have an option named '#{opt}'", called_from do
            assert_respond_to opt, subject
            assert_kind_of NsOptions::Option, subject.options[opt]
          end
        end
      end
    end

    def have_option(*args)
      called_from = caller.first
      rules, type_class, opt_name = NsOptions::Option.args(*args)
      test_name = [
        "have an option: '#{opt_name}'",
        "of type '#{type_class}'",
        "with rules '#{rules.inspect}'"
      ].join(', ')

      Assert::Macro.new(test_name) do

        should test_name do
          # name assertions
          assert_respond_to opt_name, subject

          opt = subject.options[opt_name]
          assert_kind_of NsOptions::Option, opt

          # type_class assertions
          assert_equal type_class, opt.type_class

          # rules assertions
          assert_equal rules, opt.rules
        end

      end
    end

  end

end

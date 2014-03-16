require "test_helper"
require "numeric_memoist"
require "stringio"

class FloatMemoizeTest < Test::Unit::TestCase
  class ::Float
    extend NumericMemoist
  end

  def setup
    @stdout_org = $stdout.dup
    @stdout_buffer = ""
    $stdout = StringIO.new @stdout_buffer
  end

  def test_no_args_method
    ::Float.class_eval do
      def no_args_method
        puts "call #{self}.no_args_method"
        self
      end
      memoize :no_args_method
    end
    assert_equal 1.0, 1.0.no_args_method
    assert_equal ["call 1.0.no_args_method"], @stdout_buffer.chomp.split(/\r?\n/)
    assert_equal 1.0, 1.0.no_args_method
    assert_equal ["call 1.0.no_args_method"], @stdout_buffer.chomp.split(/\r?\n/)
  end

  def test_some_args_method
    ::Float.class_eval do
      def some_args_method a, b
        puts "call #{self}.some_args_method(#{a}, #{b})"
        self * a * b
      end
      memoize :some_args_method
    end
    assert_equal 6.0, 1.0.some_args_method(2.0, 3.0)
    assert_equal ["call 1.0.some_args_method(2.0, 3.0)"], @stdout_buffer.chomp.split(/\r?\n/)
    assert_equal 6.0, 1.0.some_args_method(3.0, 2.0)
    assert_equal ["call 1.0.some_args_method(2.0, 3.0)", "call 1.0.some_args_method(3.0, 2.0)"], @stdout_buffer.chomp.split(/\r?\n/)
    assert_equal 6.0, 1.0.some_args_method(2.0, 3.0)
    assert_equal ["call 1.0.some_args_method(2.0, 3.0)", "call 1.0.some_args_method(3.0, 2.0)"], @stdout_buffer.chomp.split(/\r?\n/)
    # assert_equal 6.0, 1.0.some_args_method(2, 3)
    # assert_equal ["call 1.0.some_args_method(2.0, 3.0)", "call 1.some_args_method(3.0, 2.0)", "call 1.0.some_args_method(2, 3)"], @stdout_buffer.chomp.split(/\r?\n/)
  end

  def teardown
    $stdout = @stdout_org
  end
end
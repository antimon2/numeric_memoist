require "test_helper"
require "numeric_memoist"
require "stringio"

class IntegerMemoizeTest < Test::Unit::TestCase
  class ::Integer
    extend NumericMemoist
  end

  def stdout_buffer
    @stdout_buffer
  end

  def setup
    @stdout_org = $stdout.dup
    @stdout_buffer = ""
    $stdout = StringIO.new @stdout_buffer
  end

  def test_no_args_method
    ::Integer.class_eval do
      def no_args_method
        puts "call #{self}.no_args_method"
        self
      end
      memoize :no_args_method
    end
    assert_equal 1, 1.no_args_method
    assert_equal ["call 1.no_args_method"], @stdout_buffer.chomp.split(/\r?\n/)
    assert_equal 1, 1.no_args_method
    assert_equal ["call 1.no_args_method"], @stdout_buffer.chomp.split(/\r?\n/)
  end

  def test_some_args_method
    ::Integer.class_eval do
      def some_args_method a, b
        puts "call #{self}.some_args_method(#{a}, #{b})"
        self * a * b
      end
      memoize :some_args_method
    end
    assert_equal 6, 1.some_args_method(2, 3)
    assert_equal ["call 1.some_args_method(2, 3)"], @stdout_buffer.chomp.split(/\r?\n/)
    assert_equal 6, 1.some_args_method(3, 2)
    assert_equal ["call 1.some_args_method(2, 3)", "call 1.some_args_method(3, 2)"], @stdout_buffer.chomp.split(/\r?\n/)
    assert_equal 6, 1.some_args_method(2, 3)
    assert_equal ["call 1.some_args_method(2, 3)", "call 1.some_args_method(3, 2)"], @stdout_buffer.chomp.split(/\r?\n/)
  end

  def test_recursive_method
    ::Integer.class_eval do
      def nth_fib
        puts "call fib(#{self})"
        return (even? ? -(-self).nth_fib : (-self).nth_fib) if self < 0
        return self if self < 2
        (self - 1).nth_fib + (self - 2).nth_fib
      end
      memoize :nth_fib
    end
    assert_equal 55, 10.nth_fib
    assert_equal ["call fib(10)", "call fib(9)", "call fib(8)", "call fib(7)", "call fib(6)", "call fib(5)", "call fib(4)", "call fib(3)", "call fib(2)", "call fib(1)", "call fib(0)"], @stdout_buffer.chomp.split(/\r?\n/)
  end

  def teardown
    $stdout = @stdout_org
  end
end
require "test_helper"
require "numeric_memoist"

class NumericMemoistTest < Test::Unit::TestCase
  extend NumericMemoist

  def target_methods
    [:gcd, :lcm, :gcdlcm]
  end
  memoize :target_methods

  # def setup
  # end

  def test_memoize_exist_methods
    methods = target_methods
    assert_nothing_raised do
      ::Integer.class_eval do
        extend NumericMemoist

        memoize *methods
      end
    end
  end

  def test_memoize_non_exist_methods
    assert_raise NameError do
      ::Integer.class_eval do
        extend NumericMemoist

        memoize :not_exist_method
      end
    end
  end

  # def teardown
  # end
end
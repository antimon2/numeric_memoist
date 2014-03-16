$:.unshift File.expand_path(File.dirname(__FILE__) + "/../lib")
require 'numeric_memoist'

class Integer
  extend NumericMemoist

  def isqrt
    $stderr.puts "calculate sqrt(#{self}).to_i"
    # === Newton-Raphson method ===
    n = self
    n = (n * n + self).div(2 * n) while n * n > self
    n
  end

  def sq?
    $stderr.puts "determining if #{self} is square number"
    self.isqrt ** 2 == self
  end
  memoize :isqrt, :sq?
end

class Fixnum
  # Need not to extend NumericMemoize (Integer has already extended NumericMemoize)
  def isqrt
    return super if self > 0x1fffffffffffff
    $stderr.puts "calculate sqrt(#{self}).to_i (for Fixnum)"
    return 0.0/0 if self < 0  # => NaN
    return self if self < 2
    Math.sqrt(self).to_i
  end
  memoize :isqrt
end

if $0 == __FILE__
  p 123456789.isqrt
  # STDERR> calculate sqrt(123456789).to_i (for Fixnum)
  # STDOUT> 11111
  p 123456789.sq?
  # STDERR> determining if 123456789 is square number
  # STDOUT> false
  p 123456789.sq?
  # (output nothig to STDERR)
  # STDOUT> false
  pi2 = 986960440108935861883449099987613301336842162813430234017512025
  p pi2.sq?
  # STDERR> determining if 986960440108935861883449099987613301336842162813430234017512025 is square number
  # STDERR> calculate sqrt(986960440108935861883449099987613301336842162813430234017512025).to_i
  # STDOUT> true
  p pi2.isqrt
  # (output nothig to STDERR)
  # STDOUT> 31415926535897932384626433832795
end
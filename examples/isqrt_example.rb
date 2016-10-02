$:.unshift File.expand_path(File.dirname(__FILE__) + "/../lib")
require 'numeric_memoist'

class Integer
  extend NumericMemoist

  def isqrt
    if self < 0
      $stderr.puts "sqrt(#{self}) is not a (real) number"
      return 0.0/0  # => NaN
    elsif self < 2
      $stderr.puts "sqrt(#{self}) == #{self}."
      return self
    end
    if self <= 0x20000000000000
      $stderr.puts "calculate sqrt(#{self}).to_i (<= MaxIntFloat)"
      return Math.sqrt(self).to_i
    end
    $stderr.puts "calculate sqrt(#{self}).to_i"
    # === Newton-Raphson method ===
    n = self >> 26
    n = (n * n + self).div(2 * n) while n * n > self
    n
  end

  def sq?
    $stderr.puts "determining if #{self} is square number"
    self.isqrt ** 2 == self
  end
  memoize :isqrt, :sq?
end

if $0 == __FILE__
  p 123456789.isqrt
  # STDERR> calculate sqrt(123456789).to_i (<= MaxIntFloat)
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
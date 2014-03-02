require "numeric_memoist/version"

module NumericMemoist
  def memoize *method_names
    method_names.each do |method_name|
      _memoize method_name
    end
  end

  private
  def _memoize method_name
    klass = self.respond_to?(:class_eval) ? self : (class<<self;self;end)
    klass.class_eval do
      unmemoized_method = instance_method method_name
      is_private = private_method_defined? method_name
      is_protected = protected_method_defined? method_name
      if unmemoized_method.arity.zero?
        cache = Hash.new do |h, num|
          h[num] = unmemoized_method.bind(num).call
        end
        define_method(method_name){cache[self]}
      else
        cache = Hash.new do |h, num|
          method = unmemoized_method.bind num
          h[num] = Hash.new do |h2, args|
            h2[args] = method[*args]
          end
        end
        define_method(method_name){|*args| cache[self][args]}
      end
      private method_name if is_private
      protected method_name if is_protected
    end
  end
end
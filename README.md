# NumericMemoist

The memoize library allows you to cache methods for Numerics (Integer/Float) in Ruby >= 2.0.0.

## Installation

Add this line to your application's Gemfile:

    gem 'numeric_memoist'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install numeric_memoist

## Usage

Open class `Integer`/`Float`, extend `NumericMemoist` like the following:

    require 'numeric_memoist'

    class Integer
      extend NumericMemoist

      def sq
        self ** 2
      end
      memoize :sq
    end

Then Integer#sq will only be calcurated once. 
(These work on Ruby >= 2.0.0, and also <= 1.9.x.)

### Comparison to others

On Ruby <= 1.9.x, you may code as follows:

    class Integer
      def sq
        @sq ||= self ** 2
        # This raises RuntimeError on Ruby >= 2.0.x
      end
    end

This doesn't work on Ruby >= 2.0.0, since Integer is frozen.

You may use another similar gem like [Memoist](https://github.com/matthewrudy/memoist):

    require 'memoist'

    class Integer
      extend Memoist

      def sq
        self ** 2
      end
      memoize :sq
      # No Error raised, but momeize doesn't work on Ruby >= 2.0.x
    end

This doesn't work on Ruby >= 2.0.0 for the same reason.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Acknowledgements

Inspired by [Memoist](https://github.com/matthewrudy/memoist).

## License

Under the [MIT License](http://www.opensource.org/licenses/MIT).
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

Open class `Integer`/`Float`, extend `NumericMemoist`:

    require 'numeric_memoist'

    class Integer
      extend NumericMemoist

      def sq
        self ** 2
      end
      memoize :sq
    end

Then Integer#sq will only be calcurated once.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Acknowledgements

Inspired by [Memoist](https://github.com/matthewrudy/memoist)

## License

Under the [MIT License](http://www.opensource.org/licenses/MIT).
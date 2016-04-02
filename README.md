# Simple JSON Streaming for JRuby and friends.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sjs'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sjs

## Usage

Uses https://github.com/mguymon/simple_stream to parse a stream of JSON.

Stream json fragments to `Sjs::Simplestream`, which returns an array of entities
and optional will execute a callback. `Sjs::Simplestream` will buffer fragments for
8092 characters by default than parse it into entities. The stream
can also be flushed earlier with `flush!`

### Examples

#### Basic

    handler = Sjs::SimpleStream
    entities = handler.stream(json_fragment)
    entities += handler.flush!

#### With callback

    handler = Sjs::SimpleStream
    handler.apply_callback do |entities|
      puts entities
    end
    handler.stream(json_fragment) # entities are still returned as well in the callback
    handler.flush!

#### Stream from URL with callback

    handler = Sjs::SimpleStream
    # runs until the request finishes
    handler.stream_from_url('http://localhost/sample') do
      puts entities
    end

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sjs.

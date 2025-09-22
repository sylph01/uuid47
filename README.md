# UUID47

[![Gem Version](https://badge.fury.io/rb/uuid47.svg)](https://badge.fury.io/rb/uuid47)

Implementation of [UUIDv47](https://github.com/stateless-me/uuidv47) in Ruby

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add uuid47
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install uuid47
```

## Usage

```
require 'securerandom'

key = SecureRandom.random_bytes(16)
v7 = "018f2d9f-9a2a-7def-8c3f-7b1a2c4d5e6f" # any v7 will work
v4facade = UUID47.encode_v4facade(v7, key)
v7_recovered = UUID47.decode_v4facade(v4facade, key)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sylph01/uuid47.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

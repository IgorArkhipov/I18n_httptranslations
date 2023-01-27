# Ruby Coding Challenge - i18n backend

## Build
As an experienced Rails developer you‘re most certainly familiar with the i18n gem [1], the most popular choice to internationalise Ruby applications. The i18n gem supports multiple backends to store and retrieve translations.

Your challenge: Remote file support for the i18n gem
  - Create a Ruby gem that builds on top of the i18n library
  - This new library should support fetching translation files via HTTP rather than just relying on local translation files
  - It should be possible to fall back to local translation files in case of any network issues

[1] https://github.com/ruby-i18n/i18n

## Installation

  - Clone this repository to your local machine
  - Switch to your project, where you would like to add this Gem
  - add `gem 'phrase', path: '<your_local_path>/phrase/'` to your Gemfile
  - run `bundle`

## Usage

  - If the provided base path for the remote translation files is available, the translations will be loaded from there
  - Otherwise there is a fallback to use the locally present files

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/IgorArkhipov/phrase. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/IgorArkhipov/phrase/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Phrase project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/IgorArkhipov/phrase/blob/master/CODE_OF_CONDUCT.md).

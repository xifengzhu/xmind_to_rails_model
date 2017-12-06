# XmindToRailsModel

A simple ruby gem, parse freemind file and auto generate models and migrations.

[![Build Status](https://travis-ci.org/xifengzhu/xmind_to_rails_model.svg?branch=master)](https://travis-ci.org/xifengzhu/xmind_to_rails_model)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xmind_to_rails_model'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xmind_to_rails_model

## Usage

* Model design example

![Model design image](/images/model-design-xmind-example.png)

* Export xmind to freemind type

![Export to freemind](/images/xmind-to-freemind.png)

* Move the freemind file to the root of your project

* Run the follow command

```shell
xmind_to_rails_model ${freemind_file_name}
```

## TODO

- [ ] Add association to model
- [ ] Generate ActiveAdmin resource

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/xifengzhu/xmind_to_rails_model. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

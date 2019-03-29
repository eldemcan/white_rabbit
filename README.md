# WhiteRabbit
Rails engine for managing recurring jobs. You can use this engine in conjunction with Resque etc.

## Usage
Define you tasks inside of schedule folder and white_rabbit will pick it up. Your tasks has to include `call` method.

## Installation
- add to gem file
- rails white_rabbit:install:migrations
- `yarn build` will build front end code  if you make any changes
-  add `mount WhiteRabbit::Engine => '/white_rabbit'` to route

  Follow rails installation guide

```ruby
gem 'white_rabbit'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install white_rabbit
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

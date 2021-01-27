# WhiteRabbit ![Build Status](https://travis-ci.com/eldemcan/white_rabbit.svg?branch=master)

Rails engine for managing recurring jobs. You can use this engine in conjunction with Resque,
SideKiq etc. Build on [rufus gem](https://github.com/jmettraux/rufus-scheduler)

![overview](intro.gif)

## Usage
Define you tasks inside of app/schedule/white_rabbit folder and white_rabbit will pick it up. Your tasks has to include `call` method.

```ruby
module WhiteRabbit
  class OpenLight
    attr_reader :interval, :job, :params

    def initialize(interval = '', params)
      @interval = interval
      @params = params
    end

    def call(job, _time)
      @job = job
      Rails.logger.info("[HELLO WORLD] #{params}")
      p "Hello world, Job_id: #{job.id}"
    end
  end
end
```

## Installation
- add to gem file
- rails white_rabbit:install:migrations
- `yarn build` will build front end code  if you make any changes
-  add `mount WhiteRabbit::Engine => '/white_rabbit'` to route.rb

  Basically follow rails installation guide [install guide](https://guides.rubyonrails.org/engines.html)

## Current work
[Github board](https://github.com/eldemcan/white_rabbit/projects/1) will include work that is missing and things I like to do. Please take a look at it and contribute if you feel like it.

## Contributing
Please don't hesitate to open pr and improve this project.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

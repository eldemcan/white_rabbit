# WhiteRabbit ![Build Status](https://travis-ci.com/eldemcan/white_rabbit.svg?branch=master)
Rails engine for managing recurring jobs. You can use this engine in conjunction with Resque,
SideKiq etc. I utilized this amazing gem called [rufus](https://github.com/jmettraux/rufus-scheduler)

![overview](intro.gif)

## Usage
Define you tasks inside of schedule folder and white_rabbit will pick it up. Your tasks has to include `call` method.

## Installation
- add to gem file
- rails white_rabbit:install:migrations
- `yarn build` will build front end code  if you make any changes
-  add `mount WhiteRabbit::Engine => '/white_rabbit'` to route

  Basically follow rails installation guide [install guide](https://guides.rubyonrails.org/engines.html)

## Current work
You can see what I am currently working on [here](https://trello.com/b/iXQ509wC/rabbitwatch).

## Contributing
Please don't hesitate to open pr and improve this project.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

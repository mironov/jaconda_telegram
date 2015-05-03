# JacondaTelegram

Ruby gem to interact with Jaconda.im

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jaconda_telegram'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jaconda_telegram

## Usage

- Get token from your account at https://jaconda.im/rest_api

Example code:

```ruby
jaconda = JacondaTelegram::Api.new('YOUR_TOKEN')
```
```ruby
# Get all available groups
jaconda.list_groups
# Send Message
jaconda.send_message(126, 'Hello there!')
# Send Photo
jaconda.send_media(126, 'PATH_TO_FILE')
```
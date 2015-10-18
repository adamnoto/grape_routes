# Grape::Routes

Allow you to refer to your Grape API routes as a function call.

```ruby
class UseAPI < Grape::API
  prefix 'v1'
  format :json
  version 'v1', using: :header, vendor: 'myapi'

  resources :user do
    desc "create user"
    params do
      optional :fullname, type: String
    end
    post :create do
      # your code
    end
  end
end
```

You can refer to your API path as follow:

```ruby
Grape::Routes.v1_user_create_post_path
```

You can refer to list of all available routes:

```ruby
Grape::Routes.all_routes.keys
```

You can re-parse, only if you add routes on the fly, probably?

```ruby
Grape::Routes.parse!
```end

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'grape_routes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grape_routes

## License

The gem is proudly available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


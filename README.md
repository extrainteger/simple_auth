# Grape Simple Auth

Grape Simple Auth is a Grape middleware to connect your API resources with your API authenticator.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'grape_simple_auth'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grape_simple_auth

## Usage

### Install generator

On your first install, run this generator :

```ruby
rails g grape_simple_auth:install
```

### Configuration

After you install generator, it is expecting you to add details :

1. `ENV["AUTH_BASE_URL"]`
2. `ENV["VERIFY_ENDPOINT]`

### Usage with Grape

You will need to use the middleware in your main API :

```ruby
# use middleware
use ::GrapeSimpleAuth::Oauth2
```

You could also use the helpers :

```ruby
# use helpers
helpers ::GrapeSimpleAuth::Helpers
```

And also don't forget to rescue the invalid token :

```ruby
# rescue invalid token
rescue_from GrapeSimpleAuth::Errors::InvalidToken do |e|
  error!(e, 401)
end
rescue_from GrapeSimpleAuth::Errors::InvalidScope do |e|
  error!(e, 401)
end
rescue_from GrapeSimpleAuth::Errors::InvalidScopeMatcher do |e|
  error!(e, 401)
end
```

### Protecting your endpoint

In your endpoint you need to define which protected endpoint by adding this DSL :

1.  `oauth2` => Any scopes as long as the token is valid
2.  `oauth2 "email"` => Scope can be "email"
3.  `oauth2 "email", match: "all"` => Scope must be "email"
4.  `oauth2 "email", "phone"` Scopes can match "email" or "phone"
5.  `oauth2 "email", "phone", match: "all"` Scopes must match "email" and "phone"

Example :

```ruby
desc "Your protected endpoint"
oauth2 
get :protected do
    # your code goes here
end
```

```ruby
desc "Your protected endpoint with defined scope"
oauth2 "email"
get :protected do
    # your code goes here
end
```

## Nice feature

From your protected endpoint you could get :

1. `the_access_token` => Your access token
2. `credentials` => Full credentials
3. `current_user` => Current user (Openstruct, which means you could get `current_user.id`)

## Integration with API authenticator

Simple Auth needs your API authenticator to output specific payload :

1. `data` -> `info` => It will be your current_user
2. `data` -> `credential` => It will be your credential

Any payload inside `info` will be returned as `current_user`. Any payload inside `credential` will be returned as `credentials`

Example output of your verification endpoint :

```json
{
  "data": {
    "info": {
      "id": "123123",
      "email": "someone@somewhere.com",
      "first_name": "John",
      "last_name": "Doe",
    },
    "credential": {
      "access_token": "",
      "scopes": [],
      "token_type": "bearer",
      "expires_in": 7200,
      "refresh_token": "",
      "created_at": 1545487942
    }
  }
}
```



## TODO

- Add rspec test
- Configurable class of current_user instead of `OpenStruct`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/extrainteger/simple_auth. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GrapeSimpleAuth project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/extrainteger/simple_auth/blob/master/CODE_OF_CONDUCT.md).

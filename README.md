# Elefant

[![Build Status](https://travis-ci.org/defsprite/elefant.svg?branch=master)](https://travis-ci.org/defsprite/elefant)

When you are running a small / medium sized project, there is usually not a dedicated DBA and you rarely care about the database analytics that PostgreSQL gives you for free.
Elefant tries to help a little with that by providing web interface for some basic database analytics as a small mountable rack application.

## Installation

Add this line to your application's Gemfile:

    gem 'elefant'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elefant

## Usage

### Standalone

Run the web interface as a standalone rack application:

    $ DATABASE_URL=postgres:///some_db_connection_string elefant-web
    
or if you want to use a different database specifically for elefant:

    $ ELEFANT_DATABASE_URL=postgres:///some_db_connection_string elefant-web

### Rails
    
You can mount the web interface in a rails application by adding this to `config/routes.rb`:

```ruby
require 'elefant/web'
mount Elefant::Web => '/elefant'
```
It will pick up a connection from the `ActiveRecord` connection pool.

:warning: There is no authentication built in! Mounting it as described above is probably a bad idea! :warning:

In case you are using [Devise](https://github.com/plataformatec/devise), here is an example of mounting only for 
authenticated users of the `:admin` scope:

```ruby
authenticate(:admin) do
  require 'elefant/web'
  mount Elefant::Web => '/elefant'
end 
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

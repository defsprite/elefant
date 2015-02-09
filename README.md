# Elefant

[![Build Status](https://travis-ci.org/defsprite/elefant.svg?branch=master)](https://travis-ci.org/defsprite/elefant)

When you are running a small / medium sized project, there is usually not a dedicated DBA and you rarely care about the database analytics that PostgreSQL gives you for free.
Elefant tries to help a little with that by providing a small mountable rack application, that gives you a few insights into your database.

## Installation

Add this line to your application's Gemfile:

    gem 'elefant'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elefant

## Usage

### Standalone

    $ DATABASE_URL=postgres:///some_local_db elefant-web

- configure DATABASE_URL or ELEPHANT_DATABASE_URL
- mount as rack app in rails
- run standalone via rackup

## TODO

- detect active record and use connection from pool.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

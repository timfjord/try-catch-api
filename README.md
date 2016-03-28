## README

[![Build Status](https://travis-ci.org/timsly/try-catch-api.svg?branch=master)](https://travis-ci.org/timsly/try-catch-api)

Live url: https://try-catch-api.herokuapp.com/

### Requirements

* ruby 2.2 or higher
* PostgreSQL
* Bundler

### Setup

    $ bundle install
    $ createuser -d try_catch
    $ rails db:create
    $ rails db:migrate

#### Seeds

To add some sample data run

    $ rails db:seed

It will create two teams with players and 4 users:

* admin@try-catch.com - admin user
* user1@try-catch.com - regular user
* user2@try-catch.com - regular user
* guest@try-catch.com - guest user

All users have password 123456

### Test suite

    $ rspec

or

    $ rake

WebMQ [![Build Status](https://travis-ci.org/mindscratch/webmq.png)](https://travis-ci.org/mindscratch/webmq) [![Coverage Status](https://coveralls.io/repos/mindscratch/webmq/badge.png?branch=master)](https://coveralls.io/r/mindscratch/webmq?branch=master)

## Rubies

The aim is for this to work with Ruby 1.9 .x- 2.x, JRuby 1.7.x, Rubinius 1.9x...but none of the Ruby 1.8.x (including JRuby and Rubinius)

## Architecture

- built on [rails-api](https://github.com/rails-api/rails-api)
- uses [grape](https://github.com/intridea/grape)
- api docs generated using [grape-swagger](https://github.com/tim-vandecasteele/grape-swagger)

## Configuration

Modify the `default_url_options` in the various environment files as appropriate.
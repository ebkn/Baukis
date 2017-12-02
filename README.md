# Baukis

## Description

Baukis is a customer management system for company.

This is sample for studying Ruby on Rails.

## Dependencies

- Ruby 2.4.2
- Rails 5.0.6
- MySQL

## Setup

```sh
$ git clone git@github.com:ebkn12/Baukis.git

$ cd baukis

$ rails db:create

$ rails db:migrate

$ rails db:seed

$ bundle install --path vendor/bundle

$ rails s
```

## Development

Add host settings.
```
$ sudo vi /private/etc/hosts
```

Add following text in last line. (Do not override)
```sh
127.0.0.1 baukis.example.com example.com
```

Access following links.
```
administrators page
http://baukis.example.com/administrators

staff members page
http://baukis.example.com

customers page
http://example.com/mypage
```

This is email & password for development.
```
# administrator
admin@test.com
password

# staff_member
staff@test.com
password

# customer
customer@test.com
password
```

## Test

Run this command
```sh
$ rspec
```

then overage report is created by simpleCov gem.
```
/coverage/index.html
```

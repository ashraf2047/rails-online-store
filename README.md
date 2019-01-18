# Mock online store built with Rails 5

A server-side web API used to fetch products from an inventory.

## API Endpoints

The API exposes the following RESTful endpoints. 

| Endpoint | Functionality | Header Parameters | Query Parameters
| --- | --- | --- | --- | 
| POST /signup | Signup | N/A| name=value email=value password=value password_confirmation=value
| POST /auth/login | Login | N/A | email=value password=value
| GET /products | **A)** List all products or **B)** List all products available for purchase| Authorization:web_token| **A)** N/A **B)** available=true
| GET /products/id | Get a product | Authorization:web_token | N/A |
| POST /products | Create a product | Authorization:web_token | name=value price=value inventory_count=value id=value
| PUT /products/id | **A)** Update a products name or **B)** Purchase a product | Authorization:web_token | **A)** name=value **B)** purchase=true
| DELETE /products/id | Delete a product | Authorization:web_token | N/A

# Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing.

## Prerequisites
Make sure you have ruby version >=2.2.2 and rails version 5

```
$ ruby -v # ruby 2.3.7p456 (2018-03-28 revision 63024) [universal.x86_64-darwin17]
$ rails -v # Rails 5.2.2
```

## Clone the repository

```
git clone https://github.com/ashraf2047/rails-online-store.git && cd 
```

## Dependencies

### These Dependencies are included in the Gemfile so there is no need to download externally, just run 

```
bundle install

```

rspec-rails - Testing framework.
factory_bot_rails - A fixtures replacement with a more straightforward syntax.
shoulda_matchers - Provides RSpec with additional matchers.
database_cleaner - Cleans the test database to ensure a clean state in each test suite.
faker - A library for generating fake data
bcrypt- Used for password hashing 
jwt - Token-based authentication

## Running Tests

To run the Rspec's automated test suite :

```
bundle exec rspec
```

## Usage





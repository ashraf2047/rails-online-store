# Mock online store built with Rails 5

A server-side web API used to create, update, fetch, purchase and delete products from a store.

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
Make sure you have ruby version >=2.2.2 and rails version >= 5.0.0

```
$ ruby -v # ruby 2.3.7p456 (2018-03-28 revision 63024) [universal.x86_64-darwin17]
$ rails -v # Rails 5.2.2
```

## Clone the repository

```
git clone https://github.com/ashraf2047/rails-online-store.git && cd rails-online-store
```

## Dependencies

These dependencies are included in the Gemfile so there is no need to download externally, just run 

```
bundle install
```

* [rspec-rails](https://github.com/rspec/rspec-rails) - Testing framework.
* [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails) - A fixtures replacement with a more straightforward syntax.
* [shoulda_matchers](https://github.com/thoughtbot/shoulda-matchers) - Provides RSpec with additional matchers.
* [database_cleaner](https://github.com/DatabaseCleaner/database_cleaner) - Cleans the test database to ensure a clean state in each test suite.
* [faker](https://github.com/stympy/faker) - A library for generating fake data
* [bcrypt](https://en.wikipedia.org/wiki/Bcrypt) - Used for password hashing 
* [jwt](https://jwt.io/) - Token-based authentication

## Running Tests

To run the Rspec's automated test suite :

```
bundle exec rspec
```

# Sample Deployment

## This example makes http requests to the API using [httpie](https://httpie.org/)

### First things first, lets start up the rails server
```
$ rails s 
=> Booting Puma
=> Rails 5.2.2 application starting in development
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.12.0 (ruby 2.3.7-p456), codename: Llamas in Pajamas
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop
```
### Then sign up a user - this returns the web token used for authentication

```
$ http 0.0.0.0:3000/signup name=Joe email=Joe@email.com password=foobar password_confirmation=foobar
HTTP/1.1 201 Created
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"87205a601ea04cf781efc9d0990ed5a8"
Transfer-Encoding: chunked
X-Request-Id: 9ee41b83-8c99-4513-9095-c3472e42a6fb
X-Runtime: 0.267219

{
    "auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDc5NDc5MzN9.-VLGzXlWTGj8S8x3Yz5Lvag2M8JU91LELwml8uDIJBc",
    "message": "Account created successfully"
}
```

### Now add some products to the store

```
$ http POST 0.0.0.0:3000/products name='Nike Air Force'  price='100' inventory_count='5' id=1 \
> Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDc5NDg3MjJ9.ZHc1RaFiuu2-4L9BN8kpqdjOY-lXRWUGfRHy6g_gkSk

{
    "created_at": "2019-01-19T01:52:23.751Z",
    "created_by": "1",
    "id": 1,
    "inventory_count": 5,
    "name": "Nike Air Force",
    "price": 100,
    "updated_at": "2019-01-19T01:52:23.751Z"
}

$ http POST 0.0.0.0:3000/products name='Gucci Shoes'  price='300' inventory_count='0' id=2 \
> Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDc5NDg3MjJ9.ZHc1RaFiuu2-4L9BN8kpqdjOY-lXRWUGfRHy6g_gkSk

{
    "created_at": "2019-01-19T01:55:12.932Z",
    "created_by": "1",
    "id": 2,
    "inventory_count": 0,
    "name": "Gucci Shoes",
    "price": 300,
    "updated_at": "2019-01-19T01:55:12.932Z"
}

$ http POST 0.0.0.0:3000/products name='Jansport Backpack'  price='40' inventory_count='3' id=3 \
Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDc5NDg3MjJ9.ZHc1RaFiuu2-4L9BN8kpqdjOY-lXRWUGfRHy6g_gkSk

{
    "created_at": "2019-01-19T01:55:53.203Z",
    "created_by": "1",
    "id": 3,
    "inventory_count": 3,
    "name": "Jansport Backpack",
    "price": 40,
    "updated_at": "2019-01-19T01:55:53.203Z"
}

$ http POST 0.0.0.0:3000/products name='Apple Air Pods'  price='200' inventory_count='0' id=4 \
> Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDc5NDg3MjJ9.ZHc1RaFiuu2-4L9BN8kpqdjOY-lXRWUGfRHy6g_gkSk

{
    "created_at": "2019-01-19T01:58:36.089Z",
    "created_by": "1",
    "id": 4,
    "inventory_count": 0,
    "name": "Apple Air Pods",
    "price": 200,
    "updated_at": "2019-01-19T01:58:36.089Z"
}
```

### Lets view all products in the store

```
$ http  0.0.0.0:3000/products  \
> Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDc5NDg3MjJ9.ZHc1RaFiuu2-4L9BN8kpqdjOY-lXRWUGfRHy6g_gkSk

[
    {
        "created_at": "2019-01-19T01:52:23.751Z",
        "created_by": "1",
        "id": 1,
        "inventory_count": 5,
        "name": "Nike Air Force",
        "price": 100,
        "updated_at": "2019-01-19T01:52:23.751Z"
    },
    {
        "created_at": "2019-01-19T01:55:12.932Z",
        "created_by": "1",
        "id": 2,
        "inventory_count": 0,
        "name": "Gucci Shoes",
        "price": 300,
        "updated_at": "2019-01-19T01:55:12.932Z"
    },
    {
        "created_at": "2019-01-19T01:55:53.203Z",
        "created_by": "1",
        "id": 3,
        "inventory_count": 3,
        "name": "Jansport Backpack",
        "price": 40,
        "updated_at": "2019-01-19T01:55:53.203Z"
    },
    {
        "created_at": "2019-01-19T01:58:36.089Z",
        "created_by": "1",
        "id": 4,
        "inventory_count": 0,
        "name": "Apple Air Pods",
        "price": 200,
        "updated_at": "2019-01-19T01:58:36.089Z"
    }
]
```

### Lets view all the products with available inventory 

```
$ http GET 0.0.0.0:3000/products available='true' \
> Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDc5NDg3MjJ9.ZHc1RaFiuu2-4L9BN8kpqdjOY-lXRWUGfRHy6g_gkSk

[
    {
        "created_at": "2019-01-19T01:52:23.751Z",
        "created_by": "1",
        "id": 1,
        "inventory_count": 5,
        "name": "Nike Air Force",
        "price": 100,
        "updated_at": "2019-01-19T01:52:23.751Z"
    },
    {
        "created_at": "2019-01-19T01:55:53.203Z",
        "created_by": "1",
        "id": 3,
        "inventory_count": 3,
        "name": "Jansport Backpack",
        "price": 40,
        "updated_at": "2019-01-19T01:55:53.203Z"
    }
]
```

### Get a product by its id

```
$ http GET 0.0.0.0:3000/products/1 \
> Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDc5NDg3MjJ9.ZHc1RaFiuu2-4L9BN8kpqdjOY-lXRWUGfRHy6g_gkSk

{
    "created_at": "2019-01-19T01:52:23.751Z",
    "created_by": "1",
    "id": 1,
    "inventory_count": 5,
    "name": "Nike Air Force",
    "price": 100,
    "updated_at": "2019-01-19T01:52:23.751Z"
}
```

### Purchase a product - this reduces the inventory_count field by 1

```
$ http PUT 0.0.0.0:3000/products/1 purchase='true' \
> Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDc5NDg3MjJ9.ZHc1RaFiuu2-4L9BN8kpqdjOY-lXRWUGfRHy6g_gkSk

Item Purchased

# Getting the product again shows a decreased inventory_count 

$ http GET 0.0.0.0:3000/products/1 \
Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDc5NDg3MjJ9.ZHc1RaFiuu2-4L9BN8kpqdjOY-lXRWUGfRHy6g_gkSk

{
    "created_at": "2019-01-19T01:52:23.751Z",
    "created_by": "1",
    "id": 1,
    "inventory_count": 4,
    "name": "Nike Air Force",
    "price": 100,
    "updated_at": "2019-01-19T01:52:23.751Z"
}

```

### Attempting to purchase a product with no inventory 

```
$ http PUT 0.0.0.0:3000/products/4 purchase='true' \
> Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDc5NDg3MjJ9.ZHc1RaFiuu2-4L9BN8kpqdjOY-lXRWUGfRHy6g_gkSk

Cannot purchase item, inventory count is 0

```

### Delete a product

```
$ http DELETE 0.0.0.0:3000/products/4 \
> Authorization:eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDc5NDg3MjJ9.ZHc1RaFiuu2-4L9BN8kpqdjOY-lXRWUGfRHy6g_gkSk

```
## Thought Process / Inspiration

 * This API was designed to be simple and easy to follow, yet robust and heavily tested. 
 * It uses the ubiquitious RESTful protocal and exposes clearly defined endpoints.
 * It implements token-based user authentication to introduce an aspect of security and information hiding.
 * The Rspec test framework validates the API routes, exception handling and controller/resource management.
 * Some improvements would be to include API versioning and paganation features.




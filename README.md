# Mock online store built with Rails 5

A server-side web API used to fetch products from an inventory.

## API Endpoints

The API exposes the following RESTful endpoints. 

| Endpoint | Functionality | Header Parameters | Query Parameters
| --- | --- | --- | --- | 
| POST /signup | Signup | N/A| name=value email=value password=value password_confirmation=value
| POST /auth/login | Login | N/A | email=value password=value
| GET /products | 1) List all products 2) List products available for purchase| Authorization:web_token| 1) N/A 2) available=true
| GET /products/id | Get a product with a specific id | Authorization:web_token | N/A |
| POST /products | Create a product | Authorization:web_token | name=value price=value inventory_count=value id=value
| PUT /products/id | 1) Update a products name 2) Purchase a product | Authorization:web_token | 1) name=value 2) purchase=true
| DELETE /products/id | Delete a product | Authorization:web_token | N/A

## Getting Started

# Prerequisites

# Dependencies

# Running Tests

# Sample Deployment 





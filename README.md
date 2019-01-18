# Mock online store built with Rails 5

A server-side web API used to fetch products from an inventory.

## API Endpoints

The API exposes the following RESTful endpoints. 

| Endpoint | Functionality | Header Parameters | Query Parameters
| --- | --- | --- | --- | 
| POST /signup | Signup | N/A| name=value email=value password=value password_confirmation=value
| POST /auth/login | Login | N/A | email=value password=value
| GET /products | **A** List all products or **B** List products available for purchase| Authorization:web_token| **A** N/A **B** available=true
| GET /products/id | Get a product with a specific id | Authorization:web_token | N/A |
| POST /products | Create a product | Authorization:web_token | name=value price=value inventory_count=value id=value
| PUT /products/id | **A** Update a products name or **B** Purchase a product | Authorization:web_token | **A** name=value **B** purchase=true
| DELETE /products/id | Delete a product | Authorization:web_token | N/A

## Getting Started

# Prerequisites

# Dependencies

# Running Tests

# Sample Deployment 





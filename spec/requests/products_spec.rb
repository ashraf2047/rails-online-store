require 'rails_helper'
RSpec.describe 'Todos API', type: :request do
    # initialize test data 
    let!(:products) { create_list(:product, 10) }
    let(:id) {products.first.id }


    # Test suite for GET /products
    describe 'GET /products' do
        # make HTTP get request before each example
        before { get '/products' }

        it 'returns products' do
        # Note `json` is a custom helper to parse JSON responses
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    # Test suite for GET /products/:id
    describe 'GET /products/:id' do
        before { get "/products/#{id}" }

        context 'when the record exists' do
            it 'returns the product' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do
            let(:id) {100}

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Product/)
            end
        end
    end

    # Test suite for POST /products
    describe 'POST /products' do
        # valid payload
        let(:valid_attributes) { { name: 'Nike Air Forces', price: 80 , inventory_count: 5, id:34, created_by: '1' } }

        context 'when the request is valid' do
            before { post '/products', params: valid_attributes }

            it 'creates a product' do
                expect(json['name']).to eq('Nike Air Forces')
                expect(json['price']).to eq(80)
                expect(json['inventory_count']).to eq(5)
                expect(json['created_by']).to eq('1')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            before { post '/products', params: { name: 'Foobar', price: 1, id: 4, inventory_count:5 } }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body)
                .to match(/Validation failed: Created by can't be blank/)
            end
        end
    end

    # Test suite for PUT /products/:id
    describe 'PUT /product/:id' do
        let(:valid_attributes) { { name: "Apple Watch" } }

        context 'when the record exists' do
            before { put "/products/#{id}", params: valid_attributes }

            it 'updates the record' do
                expect(response.body).to be_empty
            end

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end

    # Test suite for DELETE /products/:id
    describe 'DELETE /products/:id' do
        before { delete "/products/#{id}" }

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end
end

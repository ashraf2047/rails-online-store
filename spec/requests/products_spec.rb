require 'rails_helper'
RSpec.describe 'Products API', type: :request do
    # initialize test data 
    let(:user) { create(:user) }
    let!(:products) { create_list(:product, 10, created_by: user.id) }
    let(:id) {products.first.id }
    # authorize request
    let(:headers) { valid_headers }

    # Test suite for GET /products
    describe 'GET /products' do
        # make HTTP get request before each example
        before { get '/products', params: {}, headers: headers }

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
        before { get "/products/#{id}", params: {}, headers: headers }

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
        let(:valid_attributes) do
            { name: 'Nike Air Forces', price: 80 , inventory_count: 5, id:34, created_by: '1' }.to_json
        end

        context 'when the request is valid' do
            before { post '/products', params: valid_attributes, headers: headers }

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
            let(:invalid_atrributes) {{created_by: nil}.to_json}
            before { post '/products', params: invalid_atrributes, headers: headers }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(json['message'])
                .to match(/Validation failed: Name can't be blank, Price can't be blank, Inventory count can't be blank, Id can't be blank/)
            end
        end
    end

    # Test suite for PUT /products/:id
    describe 'PUT /product/:id' do
        let(:valid_attributes) { { name: "Apple Watch" }.to_json }

        context 'when the record exists' do
            before { put "/products/#{id}", params: valid_attributes, headers: headers }

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
        before { delete "/products/#{id}", params: {}, headers: headers }

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
    end
end

class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :update, :destroy]

    # GET /products
    def index
        if params[:available] == 'true'
            @products = Product.where.not(inventory_count: 0)
            json_response(@products)
        else 
            @products = Product.all
            json_response(@products)
        end
    end

    # POST /products
    def create
        @product = Product.create!(product_params)
        json_response(@product, :created)
    end

    # GET /products/:id
    def show
        json_response(@product)
    end

    # PUT /products/:id
    def update
        if params[:purchase] == 'true'
            if @product.inventory_count == 0
                render plain: "Cannot purchase item, inventory count is 0"
            else 
                @product.decrement!(:inventory_count, by=1,touch: nil)
                render plain: "Item Purchased"
            end
        else 
            @product.update(product_params)
            head :no_content
        end
    end

    # DELETE /products/:id
    def destroy
        @product.destroy
        head :no_content
    end

    private

    def product_params
        # whitelist params
        params.permit(:name, :price, :inventory_count, :id, :created_by)
    end

    def set_product
        @product = Product.find(params[:id])
    end

end

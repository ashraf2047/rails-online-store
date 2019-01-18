class Product < ApplicationRecord
    # validations
  validates_presence_of :name, :price, :inventory_count, :id, :created_by 

end

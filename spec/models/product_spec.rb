require 'rails_helper'

RSpec.describe Product, type: :model do

  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:inventory_count) }
  it { should validate_presence_of(:id) }
  it { should validate_presence_of(:created_by) }
end

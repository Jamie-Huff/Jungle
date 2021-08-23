require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should exist" do
      @category = Category.new(name: 'test_category')
      @product = Product.new(name: 'soup', price_cents: 1000, category: @category, quantity: 5)
      expect(@product).to be_valid
      expect(@category).to be_valid
    end

    it "should have a price" do
      @category = Category.new(name: 'test_category')
      @product = Product.new(name: 'soup', price_cents: nil, category: @category, quantity: 5)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages[0]).to eq("Price cents is not a number")
    end

    it "should have a name" do
      @category = Category.new(name: 'test_category')
      @product = Product.new(name: nil, price_cents: 1000, category: @category, quantity: 5)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages[0]).to eq("Name can't be blank")
    end

    it "should have the quantity" do
      @category = Category.new(name: 'test_category')
      @product = Product.new(name: 'soup', price_cents: 1000, category: @category, quantity: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages[0]).to eq("Quantity can't be blank")
    end

    it "should have a category" do
    @category = Category.new(name: 'test_category')
    @product = Product.new(name: 'soup', price_cents: 1000, category: nil, quantity: nil)
    expect(@product).to_not be_valid
    expect(@product.errors.full_messages[0]).to eq("Quantity can't be blank")
    end
  end
end

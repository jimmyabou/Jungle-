require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.create(name: 'newCategory')
      @product = Product.new(
        name: 'anyProduct',
        price: 1,
        quantity: 1,
        category: @category
      )
    end
    it 'has all attributes' do
      expect(@product).to be_valid
    end
    it 'no name' do
      @product.name = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'price not entered' do
      @product.price_cents = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it 'quantity not entered' do
      @product.quantity = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'no category' do
      @product.category = nil
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end

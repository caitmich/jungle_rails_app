require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      @category = Category.create(name:'Shoes')
      @name = 'stilettos'
      @price = 15000
    end

    describe '.create' do
      it 'saves successfully when all fields are completed' do
        @product = Product.create(name: @name, quantity:50, price_cents:@price, category:@category)
        expect(@product.validate).to be true
      end

      it 'does not save when name is not present' do
        @product = Product.create(name: nil, quantity:50, price_cents: @price, category:@category)
        expect(@product.validate).to be false
        expect(@product.errors.full_messages).to eql(["Name can't be blank"])
      end

      it 'does not save when price is not present' do
        @product = Product.create(name: @name, quantity:50, price_cents: nil, category:@category)
        expect(@product.validate).to be false
        expect(@product.errors.full_messages).to include("Price cents can't be blank")
        expect(@product.errors.full_messages).to include("Price cents is not a number")
      end

      it 'does not save when quantity is not present' do
        @product = Product.create(name: @name, price_cents: @price, quantity: nil, category:@category)
        expect(@product.validate).to be false
        expect(@product.errors.full_messages).to eq(["Quantity can't be blank"])
      end

      it 'does not save when category is not present' do
        @product = Product.create(name: @name, quantity:50, price_cents: @price, category: nil)
        expect(@product.validate).to be false
        expect(@product.errors.full_messages).to eql(["Category can't be blank"])
      end

    end
  end
end

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      @category = Category.create(name:'Shoes')
    end

    describe '.create' do
      it 'saves successfully when all fields are completed' do
        @product = Product.create(name: 'heels', quantity:50, price_cents:15000, category:@category)
        # @product.save!
        expect(@product.validate).to be true
      end
    end



  end
end

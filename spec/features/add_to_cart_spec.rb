require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do

     before :each do
      @category = Category.create! name: 'Apparel'
  
      10.times do |n|
        @category.products.create!(
          name:  Faker::Hipster.sentence(3),
          description: Faker::Hipster.paragraph(4),
          image: open_asset('apparel1.jpg'),
          quantity: 10,
          price: 64.99
        )
      end
    end

  xscenario "They can add a product to cart and cart icon increases by 1" do
    visit root_path
    click_button('Add', match: :first)

    page.find :link_or_button, 'My Cart (1)'

    # save_screenshot
  end
end

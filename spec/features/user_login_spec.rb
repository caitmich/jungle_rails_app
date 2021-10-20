require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  before :each do
   @user = User.new(name: "Lady Gaga", email: 'email@email.com', password: 'password', password_confirmation: 'password')

   @user.save!
 end

  scenario "They can login and are taken to homepage once logged in" do

    visit '/login'

    fill_in 'email', with: 'email@email.com'
    fill_in 'password', with: 'password'

    click_button 'Submit'

    expect(page).to have_text 'Signed in as Lady Gaga'

    save_screenshot
  end


end

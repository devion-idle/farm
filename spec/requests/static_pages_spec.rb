require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the title 'Devion Idle | Farming Empire'" do
      visit 'static_pages/home'
      expect(page).to have_title('Devion Idle | Farming Empire')
    end

    it "should have the content 'Farming Empire'" do
      visit '/static_pages/home'
      expect(page).to have_content('Farming Empire')
    end
  end
end

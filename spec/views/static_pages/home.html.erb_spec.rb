require 'spec_helper'

describe "home page" do
  	it "should have content 'HumbleCasa'" do
	  	visit '/static_pages#home'
  		page.should have_content('HumbleCasa')
    end
end

require 'rails_helper'
feature 'Short url creation' do

  scenario 'Creating a new short url' do
    visit '/'
    expect(page).to have_field('url')
  end
end

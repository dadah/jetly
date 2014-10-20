require 'rails_helper'
feature 'Short url creation' do
  given(:url_to_shorten) {
    'http://www.someurl.com/something'
  }
  given(:invalid_url) {
    'thisisnotanurl'
  }
  given(:short_url) {
    mock_model 'JetlyUrl', complete_url: url_to_shorten, url_hash: 'shrt', visits_count: 0
  }

  scenario 'Creating a new short url' do
    allow(JetlyUrl).to receive(:create).with( complete_url: url_to_shorten ).and_return short_url
    visit '/'
    fill_in 'jetly_url_complete_url', with: url_to_shorten
    click_button 'Shorten'
    expect(page).to have_content short_url.url_hash
    expect(find_field('jetly_url_complete_url').value).to eq(url_to_shorten)
    expect(page).not_to have_selector '.alert-danger'
  end

  scenario 'Tries to create with an invalid url' do
    visit '/'
    fill_in 'jetly_url_complete_url', with: invalid_url
    click_button 'Shorten'
    expect(page).to have_selector '.alert-danger'
    expect(page).not_to have_selector '#shortened_url'
  end
end

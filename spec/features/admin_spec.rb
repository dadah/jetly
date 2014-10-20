require 'rails_helper'

feature 'Admin area' do

  xit 'accesses register form' do
    visit '/'
    click_link 'Sign Up'
    expect(page.current_path).to eq('/admin/signup')
  end

end

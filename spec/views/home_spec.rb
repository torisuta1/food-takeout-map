require 'rails_helper'

RSpec.describe 'home_page' do 
  describe 'sign_in' do 
    it 'existing サインイン' do
    visit root_path
    expect(page).to have_content 'サインイン'
    end
  end
end
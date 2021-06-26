require 'rails_helper'

RSpec.describe 'home_page' do 
  describe 'sign_in' do 
    it 'existing サインイン' do
    visit root_path
    expect(page).to have_content 'サインイン'
    end
  end

  describe 'log_in' do  
    it 'existing ログイン' do 
      visit root_path
    expect(page).to have_content 'ログイン'
    end
  end

  describe 'search' do  
    it 'existing 検索' do 
      visit root_path
    expect(page).to have_content '検索'
    end
  end

  describe 'view' do  
    it 'existing 一覧' do 
      visit root_path
    expect(page).to have_content '一覧'
    end
  end

  describe 'log_out' do  
    it 'not existing ログアウト' do 
      visit root_path
    expect(page).to_not have_content 'ログアウト'
    end
  end

  describe 'my_page' do  
    it 'not existing マイページ' do 
      visit root_path
    expect(page).to_not have_selector 'li', text: 'マイページ'
    end
  end
end
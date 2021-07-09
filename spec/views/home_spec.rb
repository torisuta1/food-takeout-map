require 'rails_helper'

RSpec.describe 'home_page' do 
  before do 
    visit root_path
  end
  
  context 'sign_up' do 
    it 'existing サインアップ' do
    expect(page).to have_content 'サインアップ'
    end
  end

  context 'log_in' do  
    it 'existing ログイン' do 
    expect(page).to have_content 'ログイン'
    end
  end

  context 'search' do  
    it 'existing 検索' do 
    expect(page).to have_content '検索'
    end
  end

  context 'view' do  
    it 'existing 一覧' do 
    expect(page).to have_content '一覧'
    end
  end

  context 'log_out' do  
    it 'not existing ログアウト' do 
    expect(page).to_not have_content 'ログアウト'
    end
  end

  context 'my_page' do  
    it 'not existing マイページ' do 
    expect(page).to_not have_selector 'li', text: 'マイページ'
    end
  end
end
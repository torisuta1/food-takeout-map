require 'rails_helper'

RSpec.describe 'search_page' do 
  before do 
    visit search_posts_path
  end

  context 'search term' do  
    it 'existing 検索ワード' do 
      expect(page).to have_content '検索ワード'
    end
  end

  context 'price range' do  
    it 'existing 価格帯' do 
      expect(page).to have_content '価格帯'
    end
  end
end
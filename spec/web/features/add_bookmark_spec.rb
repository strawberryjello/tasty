require 'features_helper'

RSpec.describe 'Add a bookmark' do
  after do
    BookmarkRepository.new.clear
  end

  it 'can create a new bookmark' do
    visit '/bookmarks/new'

    within 'form#bookmark-form' do
      fill_in 'Title', with: 'Example.com'
      fill_in 'URL', with: 'https://www.example.com'

      click_button 'Save'
    end

    expect(page).to have_current_path('/bookmarks')
    expect(page).to have_content('Example.com')
  end


  it 'displays list of errors when params contains errors' do
    visit '/bookmarks/new'

    within 'form#bookmark-form' do
      click_button 'Save'
    end

    expect(current_path).to eq('/bookmarks')

    expect(page).to have_content('There was a problem with your submission')
    expect(page).to have_content('Title must be filled')

    # TODO: is it possible to uppercase the field names?
    expect(page).to have_content('Url must be filled')
  end
end

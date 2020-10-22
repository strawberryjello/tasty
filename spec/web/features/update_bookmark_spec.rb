require 'features_helper'

RSpec.describe 'Update a bookmark' do
  let(:repository) { BookmarkRepository.new }
  before do
    repository.clear

    repository.create(id: 1, title: 'HTTP Status', url: 'https://httpstatusdogs.com/')
  end

  it 'can update an existing bookmark' do
    visit '/bookmarks/1/edit'

    within 'form#bookmark-form' do
      fill_in 'Title', with: 'HTTP Status Dogs'

      click_button 'Save'
    end

    expect(page).to have_current_path('/bookmarks')
    expect(page).to have_content('HTTP Status Dogs')
  end
end

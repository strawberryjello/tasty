require 'features_helper'

RSpec.describe 'List bookmarks' do
  let(:repository) { BookmarkRepository.new }
  before do
    repository.clear

    repository.create(title: 'Hanami Guides', url: 'https://guides.hanamirb.org/introduction/getting-started/')
    repository.create(title: 'Haml', url: 'https://haml.info/')
  end

  it 'displays each bookmark on the page' do
    visit '/bookmarks'

    within '#bookmarks' do
        expect(page).to have_css('.bookmark', count: 2), 'Expected to find 2 bookmarks'
    end
  end
end

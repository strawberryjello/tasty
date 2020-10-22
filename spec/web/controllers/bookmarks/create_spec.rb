RSpec.describe Web::Controllers::Bookmarks::Create, type: :action do
  let(:action) { described_class.new }
  let(:repository) { BookmarkRepository.new }

  before do
    repository.clear
  end

  context 'with valid params' do
    let(:params) { Hash[bookmark: { title: 'HTTP Cats', url: 'https://http.cat/' }] }

    it 'creates a new bookmark' do
      action.call(params)
      bookmark = repository.last

      expect(bookmark.id).to_not be_nil
      expect(bookmark.title).to eq(params.dig(:bookmark, :title))
    end

    it 'redirects the user to the bookmarks listing' do
      response = action.call(params)
      expect(response[0]).to eq(302)
      expect(response[1]['Location']).to eq('/bookmarks')
    end
  end

  context 'with invalid params' do
    let(:params) { Hash[bookmark: {}] }

    it 'returns HTTP client error' do
      response = action.call(params)
      expect(response[0]).to eq(422)
    end

    it 'dumps errors in params' do
      action.call(params)
      errors = action.params.errors

      expect(errors.dig(:bookmark, :title)).to eq(['is missing'])
      expect(errors.dig(:bookmark, :url)).to eq(['is missing'])
    end
  end
end

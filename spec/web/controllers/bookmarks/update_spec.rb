RSpec.describe Web::Controllers::Bookmarks::Update, type: :action do
  let(:action) { described_class.new }
  let(:repository) { BookmarkRepository.new }

  before do
    repository.clear

    repository.create(id: 1, title: 'RITS', url: 'https://bugs.ruby-lang.org/')
  end

  context 'with valid params' do
    let(:params) { Hash[id: 1, bookmark: { title: 'Ruby Issue Tracking System', url: 'https://bugs.ruby-lang.org/' }] }

    it 'updates an existing bookmark' do
      action.call(params)
      bookmark = repository.find(params[:id])

      expect(bookmark.title).to eq(params.dig(:bookmark, :title))
    end

    it 'redirects the user to the bookmarks listing' do
      response = action.call(params)
      expect(response[0]).to eq(302)
      expect(response[1]['Location']).to eq('/bookmarks')
    end
  end
end

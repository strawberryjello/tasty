
RSpec.describe Web::Views::Bookmarks::Index do
  let(:exposures) { Hash[bookmarks: []] }
  let(:template) { Hanami::View::Template.new('apps/web/templates/bookmarks/index.html.haml')}
  let(:view) { described_class.new(template, exposures) }
  let(:rendered) { view.render }

  it 'exposes #bookmarks' do
    expect(view.bookmarks).to eq(exposures.fetch(:bookmarks))
  end

  context 'when there are no bookmarks' do
    it 'shows a placeholder message' do
      expect(rendered).to include('<p class=\'placeholder\'>There are no bookmarks yet.</p>')
    end
  end

  context 'when there are bookmarks' do
    let(:bookmark1) { Bookmark.new(id: 1, title: 'Wikipedia', url: 'https://www.wikipedia.org/') }
    let(:bookmark2) { Bookmark.new(id: 2, title: 'Wiktionary', url: 'https://www.wiktionary.org/') }
    let(:exposures) { Hash[bookmarks: [bookmark1, bookmark2]] }

    it 'lists them all' do
      expect(rendered.scan(/class='bookmark'/).length).to eq(2)
      expect(rendered).to include('Wikipedia')
      expect(rendered).to include('Wiktionary')
    end

    it 'hides the placeholder message' do
      expect(rendered).to_not include('<p class=\'placeholder\'>There are no bookmarks yet.</p>')
    end
  end
end

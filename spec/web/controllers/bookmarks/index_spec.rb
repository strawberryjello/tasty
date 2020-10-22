RSpec.describe Web::Controllers::Bookmarks::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }
  let(:repository) { BookmarkRepository.new }

  before do
    repository.clear

    @bookmark = repository.create(title: 'Ruby-Doc.org', url: 'https://ruby-doc.org/')
  end

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end

  it 'exposes all bookmarks' do
    action.call(params)
    expect(action.exposures[:bookmarks]).to eq([@bookmark])
  end
end

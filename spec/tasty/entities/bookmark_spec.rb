RSpec.describe Bookmark, type: :entity do
  it 'can be initialized with attributes' do
    title = 'How to be a cat'
    bookmark = Bookmark.new(title: title)
    expect(bookmark.title).to eq(title)
  end
end

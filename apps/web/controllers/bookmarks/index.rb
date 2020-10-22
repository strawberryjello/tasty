module Web
  module Controllers
    module Bookmarks
      class Index
        include Web::Action

        expose :bookmarks

        def call(params)
          @bookmarks = BookmarkRepository.new.all
        end
      end
    end
  end
end

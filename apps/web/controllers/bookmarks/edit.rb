module Web
  module Controllers
    module Bookmarks
      class Edit
        include Web::Action

        expose :bookmark

        def call(params)
          # TODO: restrict params[:id]
          @bookmark = BookmarkRepository.new.find(params[:id])
        end
      end
    end
  end
end

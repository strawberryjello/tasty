module Web
  module Controllers
    module Bookmarks
      class Create
        include Web::Action

        expose :bookmark

        params do
          required(:bookmark).schema do
            required(:title).filled(:str?)
            required(:url).filled(:str?, format?: URI.regexp(%w(http https)))
          end
        end

        def call(params)
          if params.valid?
            @bookmark = BookmarkRepository.new.create(params[:bookmark])

            redirect_to routes.bookmarks_path
          else
            self.status = 422
          end
        end
      end
    end
  end
end

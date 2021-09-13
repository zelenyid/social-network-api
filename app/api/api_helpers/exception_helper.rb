module APIHelpers
  module ExceptionHelper
    def not_found
      error!('404 Not found', 404)
    end
  end
end

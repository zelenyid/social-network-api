module APIHelpers
  module AuthenticationHelper
    def current_user
      @current_user ||= env['warden'].authenticate
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end
  end
end

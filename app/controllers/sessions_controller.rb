class SessionsController < Devise::SessionsController
  respond_to :json

  # POST /users/sign_in
  # Specs No
  def create # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    # Check both because rspec vs normal server requests .... do different things? WTF.
    possible_aud = request.headers['HTTP_JWT_AUD'].presence || request.headers['JWT_AUD'].presence
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    if user_signed_in?
      last = resource.allowlisted_jwts.where(aud: possible_aud).last
      aud = possible_aud || 'UNKNOWN'
      if last.present?
        last.update_columns({ # rubocop:disable Rails/SkipsModelValidations
                              browser_data: params[:browser],
                              os_data: params[:os],
                              remote_ip: params[:ip]
                            })
        aud = last.aud
      end
      respond_with(resource, { aud: aud })
    else
      render json: resource.errors, status: :unauthorized
    end
  rescue StandardError
    render json: { error: I18n.t('api.oops') }, status: :internal_server_error
  end

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def respond_with(resource, opts = {})
    render json: {
      user: resource.for_display,
      jwt: current_token,
      aud: opts[:aud]
    }
  end

  def respond_to_on_destroy
    render json: { message: I18n.t('controllers.sessions.sign_out') }
  end
end

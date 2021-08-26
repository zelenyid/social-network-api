class DeviseCustomFailure < Devise::FailureApp
  def respond # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    path_params = request.path_parameters
    control = path_params[:controller]
    act = path_params[:action]
    if control == 'api/v1/ping' && act == 'index'
      classify = control.classify.pluralize

      warden_options[:recall] = "#{classify}##{act}"
      request.headers['auth_failure'] = true
      request.headers['auth_failure_message'] = i18n_message
      recall
    else
      http_auth
    end
  end

  def http_auth_body
    {
      authFailure: true,
      error: i18n_message
    }.to_json
  end
end

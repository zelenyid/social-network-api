require 'rails_helper'

RSpec.describe 'Session', type: :request do
  let!(:user) { create(:confirmed_user) }

  describe 'POST #login' do
    it 'response is successful' do
      headers = { HTTP_JWT_AUD: 'test' }
      post '/users/sign_in', params: { user: { email: user.email, password: user.password } }, headers: headers

      expect(response).to be_successful
    end
  end
end

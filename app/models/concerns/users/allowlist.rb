module Users
  module Allowlist
    extend ActiveSupport::Concern

    included do
      has_many :allowlisted_jwts, dependent: :destroy

      def self.jwt_revoked?(payload, user)
        !user.allowlisted_jwts.exists?(payload.slice('jti', 'aud'))
      end

      def self.revoke_jwt(payload, user)
        jwt = user.allowlisted_jwts.find_by(payload.slice('jti', 'aud'))
        jwt&.destroy!
      end
    end

    def on_jwt_dispatch(_token, payload) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      prev_token = allowlisted_jwts.where(aud: payload['aud']).where.not(exp: ..Time.zone.now).last
      token = allowlisted_jwts.create!(
        jti: payload['jti'],
        aud: payload['aud'].presence || 'UNKNOWN',
        exp: Time.zone.at(payload['exp'].to_i)
      )
      if token.present? && prev_token.present?
        token.update_columns({ # rubocop:disable Rails/SkipsModelValidations
                               browser_data: prev_token.browser_data,
                               os_data: prev_token.os_data,
                               remote_ip: prev_token.remote_ip
                             })
      end
      token
    end
  end
end

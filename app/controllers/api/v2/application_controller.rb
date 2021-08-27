class API::V2::ApplicationController < ApplicationController
  before_action :authenticate_user!
end

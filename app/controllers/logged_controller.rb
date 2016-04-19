class LoggedController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :authenticate_user!

  layout "logged"
  prepend_view_path "app/views/logged"
end
